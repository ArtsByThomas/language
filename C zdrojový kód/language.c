#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKENS 50000
#define MAX_TOKEN_LEN 256

#define OS_WINDOWS 1
#define OS_LINUX 2
#define OS_KERNEL 3

int global_str_counter = 0;

#define O_SIGN(off) ((off) < 0 ? "+" : "-")
#define O_ABS(off) ((off) < 0 ? -(off) : (off))

#define MEMORY_POOL_SIZE (1024 * 1024 * 10) 
unsigned char memory_pool[MEMORY_POOL_SIZE];
size_t memory_offset = 0;

void error_at(int line, const char* msg) {
    printf("Chyba na radku %d: %s\n", line, msg);
    fflush(stdout);
    exit(1);
}

void* custom_malloc(size_t size) {
    size_t remainder = size % 8;
    if (remainder != 0) size += (8 - remainder);
    if (memory_offset + size > MEMORY_POOL_SIZE) { printf("Chyba: Nedostatek pameti!\n"); fflush(stdout); exit(1); }
    void* ptr = &memory_pool[memory_offset];
    memory_offset += size;
    return ptr;
}

void* custom_calloc(size_t num, size_t size) {
    size_t total = num * size;
    void* ptr = custom_malloc(total);
    memset(ptr, 0, total); 
    return ptr;
}

typedef enum {
    TOKEN_VYPIS, TOKEN_VYPIS_HODNOTU, TOKEN_CTI_HODNOTU,
    TOKEN_OPAKUJ, TOKEN_METODA, TOKEN_VOLEJ, TOKEN_VRAT,
    TOKEN_DOKUD, TOKEN_PRO, TOKEN_UKONCI, TOKEN_POKRACUJ,
    TOKEN_GLOBALNI, TOKEN_GLOBALNI_POLE, TOKEN_KONSTANTA, TOKEN_VELIKOST,
    TOKEN_LOKALNI, TOKEN_LOKALNI_POLE,
    TOKEN_STRUKTURA, TOKEN_INSTANCE, TOKEN_DOT, TOKEN_ARROW,
    TOKEN_POKUD, TOKEN_JINAK,
    TOKEN_ASM, TOKEN_ZAPIS_ADRESU, TOKEN_CTI_ADRESU,
    TOKEN_OTEVRI_SOUBOR, TOKEN_ZAVRI_SOUBOR, TOKEN_CTI_ZNAK, TOKEN_ZAPIS_ZNAK,
    TOKEN_CTI_BYTE, TOKEN_ZAPIS_BYTE, 
    TOKEN_EXTERNI,
    TOKEN_STRING, TOKEN_NUMBER, TOKEN_IDENTIFIER,
    TOKEN_LBRACE, TOKEN_RBRACE, TOKEN_LBRACKET, TOKEN_RBRACKET, 
    TOKEN_LPAREN, TOKEN_RPAREN, 
    TOKEN_EQ, TOKEN_EQEQ, TOKEN_NEQ, TOKEN_LESS, TOKEN_GREATER, TOKEN_COLON,
    TOKEN_PLUS, TOKEN_MINUS, TOKEN_MUL, TOKEN_DIV,
    TOKEN_AND, TOKEN_OR, TOKEN_XOR, TOKEN_SHL, TOKEN_SHR,
    TOKEN_AMPER, TOKEN_COMMA, TOKEN_NOT, 
    TOKEN_AND_LOGICAL, TOKEN_OR_LOGICAL,
    TOKEN_LESSEQ, TOKEN_GREATEREQ,
    TOKEN_UNKNOWN, TOKEN_EOF
} TokenType;

typedef struct { TokenType type; char value[MAX_TOKEN_LEN]; int str_id; int line; } Token;
typedef struct { 
    char name[MAX_TOKEN_LEN]; int is_global; int is_const; int const_val;
    char init_str[64]; int offset; int dim1, dim2; char type_name[64]; 
} Symbol;

typedef struct { 
    char name[64]; char members[50][64]; int member_offsets[50]; int member_is_array[50];
    int count; int total_bytes;
} StructDef;

StructDef struct_registry[50];
int struct_count = 0;

int get_struct_bytes(const char* name, int step) {
    for(int i=0; i<struct_count; i++) if(strncmp(struct_registry[i].name, name, 63)==0) return struct_registry[i].total_bytes;
    return step;
}
int get_member_offset(const char* s_name, const char* m_name, int step, int line) {
    for(int i=0; i<struct_count; i++) {
        if(strncmp(struct_registry[i].name, s_name, 63)==0) {
            for(int j=0; j<struct_registry[i].count; j++) {
                if(strncmp(struct_registry[i].members[j], m_name, 63)==0) return struct_registry[i].member_offsets[j];
            }
        }
    }
    error_at(line, "Vlastnost ve strukture neexistuje!");
    return 0;
}
int get_member_is_array(const char* s_name, const char* m_name) {
    for(int i=0; i<struct_count; i++) {
        if(strncmp(struct_registry[i].name, s_name, 63)==0) {
            for(int j=0; j<struct_registry[i].count; j++) {
                if(strncmp(struct_registry[i].members[j], m_name, 63)==0) return struct_registry[i].member_is_array[j];
            }
        }
    }
    return 0;
}

Symbol sym_table[2000]; int sym_count = 0; int current_local_offset = 0;
int codegen_method_sym_start = -1;
int codegen_method_sym_end = 1000000;

void add_global_symbol(const char *name) { 
    strncpy(sym_table[sym_count].name, name, MAX_TOKEN_LEN-1); 
    sym_table[sym_count].is_global = 1; sym_table[sym_count].is_const = 0;
    sym_count++; 
}

void add_local_symbol(const char *name, int byte_size, int d1, int d2, const char* type_name) {
    strncpy(sym_table[sym_count].name, name, MAX_TOKEN_LEN-1); sym_table[sym_count].is_global = 0;
    sym_table[sym_count].dim1 = d1; sym_table[sym_count].dim2 = d2;
    if(type_name) strncpy(sym_table[sym_count].type_name, type_name, 63); else sym_table[sym_count].type_name[0] = '\0';
    current_local_offset += byte_size; sym_table[sym_count].offset = current_local_offset; sym_count++;
}

Symbol* find_symbol(const char *name) {
    for (int i = sym_count - 1; i >= 0; i--) {
        if (strncmp(sym_table[i].name, name, MAX_TOKEN_LEN-1) == 0) {
            if (codegen_method_sym_start < 0 || sym_table[i].is_global || (i >= codegen_method_sym_start && i < codegen_method_sym_end)) return &sym_table[i];
        }
    }
    return NULL;
}

// Kontrola pouziti '->' primo pri parsovani (misto az pri generovani ASM).
// Overi ze: 1) promenna existuje, 2) ma anotovany typ (': Typ' u Lokalni/parametru), 3) vlastnost ve strukture existuje.
void check_ptr_member_access(const char *var_name, const char *member_name, int line) {
    Symbol *s = find_symbol(var_name);
    if (!s) {
        char msg[128]; sprintf(msg, "Nedeklarovana promenna '%s' pouzita s '->'!", var_name);
        error_at(line, msg);
    }
    if (s->type_name[0] == '\0') {
        char msg[192]; sprintf(msg, "Promenna '%s' nema anotovany typ (chybi ': Typ' u Lokalni/parametru) - nelze pouzit '->'!", var_name);
        error_at(line, msg);
    }
    get_member_offset(s->type_name, member_name, 8, line); // sam vyhodi chybu, pokud vlastnost ve strukture neexistuje
}

void tokenize(const char *filename, Token tokens[], int *token_count) {
    FILE *file = fopen(filename, "r");
    if (!file) { printf("Chyba: Nelze otevrit soubor '%s'!\n", filename); fflush(stdout); exit(1); }
    int ch, line = 1;
    while ((ch = fgetc(file)) != EOF) {
        if (ch == '\n') { line++; continue; }
        if (isspace(ch)) continue;
        if (ch == ';') continue; 

        tokens[*token_count].line = line;

        if (ch == '/') {
            int next = fgetc(file);
            if (next == '/') { while ((ch = fgetc(file)) != EOF && ch != '\n'); line++; continue; } 
            else if (next == '*') { while ((ch = fgetc(file)) != EOF) { if (ch == '\n') line++; if (ch == '*') { if ((ch = fgetc(file)) == '/') break; ungetc(ch, file); } } continue; } 
            else { ungetc(next, file); tokens[*token_count].type = TOKEN_DIV; strncpy(tokens[*token_count].value, "/", 2); (*token_count)++; continue; }
        }
        else if (ch == '"') {
            int i = 0; 
            while ((ch = fgetc(file)) != EOF && ch != '"' && i < MAX_TOKEN_LEN - 1) {
                if (ch == '\\') { ch = fgetc(file); if (ch == 'n') ch = '\n'; else if (ch == 't') ch = '\t'; }
                tokens[*token_count].value[i++] = ch;
            }
            tokens[*token_count].value[i] = '\0'; tokens[*token_count].type = TOKEN_STRING; tokens[*token_count].str_id = global_str_counter++; (*token_count)++;
        }
        else if (ch == '\'') {
            ch = fgetc(file); int val = ch;
            if (ch == '\\') { ch = fgetc(file); if (ch == 'n') val = 10; else if (ch == 't') val = 9; else if (ch == '0') val = 0; else if (ch == '\\') val = '\\'; else if (ch == '\'') val = '\''; }
            if (fgetc(file) != '\'') { error_at(line, "Ocekavan uzaviraci apostrof!"); }
            sprintf(tokens[*token_count].value, "%d", val); tokens[*token_count].type = TOKEN_NUMBER; (*token_count)++;
        }
        else if (isdigit(ch)) {
            int i = 0; tokens[*token_count].value[i++] = ch;
            while ((ch = fgetc(file)) != EOF && (isdigit(ch) || ch == 'x' || ch == 'X' || (ch >= 'A' && ch <= 'F') || (ch >= 'a' && ch <= 'f')) && i < MAX_TOKEN_LEN - 1) tokens[*token_count].value[i++] = ch;
            if (ch != EOF) ungetc(ch, file); tokens[*token_count].value[i] = '\0'; tokens[*token_count].type = TOKEN_NUMBER; (*token_count)++;
        }
        else if (ch == '=') { int next = fgetc(file); if (next == '=') { tokens[*token_count].type = TOKEN_EQEQ; strncpy(tokens[*token_count].value, "==", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_EQ; strncpy(tokens[*token_count].value, "=", 2); } (*token_count)++; }
        else if (ch == '!') { int next = fgetc(file); if (next == '=') { tokens[*token_count].type = TOKEN_NEQ; strncpy(tokens[*token_count].value, "!=", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_NOT; strncpy(tokens[*token_count].value, "!", 2); } (*token_count)++; }
        else if (ch == '<') { int next = fgetc(file); if (next == '<') { tokens[*token_count].type = TOKEN_SHL; strncpy(tokens[*token_count].value, "<<", 3); } else if (next == '=') { tokens[*token_count].type = TOKEN_LESSEQ; strncpy(tokens[*token_count].value, "<=", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_LESS; strncpy(tokens[*token_count].value, "<", 2); } (*token_count)++; }
        else if (ch == '>') { int next = fgetc(file); if (next == '>') { tokens[*token_count].type = TOKEN_SHR; strncpy(tokens[*token_count].value, ">>", 3); } else if (next == '=') { tokens[*token_count].type = TOKEN_GREATEREQ; strncpy(tokens[*token_count].value, ">=", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_GREATER; strncpy(tokens[*token_count].value, ">", 2); } (*token_count)++; }
        else if (ch == '&') { int next = fgetc(file); if (next == '&') { tokens[*token_count].type = TOKEN_AND_LOGICAL; strncpy(tokens[*token_count].value, "&&", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_AMPER; strncpy(tokens[*token_count].value, "&", 2); } (*token_count)++; }
        else if (ch == '|') { int next = fgetc(file); if (next == '|') { tokens[*token_count].type = TOKEN_OR_LOGICAL; strncpy(tokens[*token_count].value, "||", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_OR; strncpy(tokens[*token_count].value, "|", 2); } (*token_count)++; }
        else if (ch == '^') { tokens[*token_count].type = TOKEN_XOR; strncpy(tokens[*token_count].value, "^", 2); (*token_count)++; }
        else if (ch == ':') { tokens[*token_count].type = TOKEN_COLON; strncpy(tokens[*token_count].value, ":", 2); (*token_count)++; }
        else if (ch == '{') { tokens[*token_count].type = TOKEN_LBRACE; strncpy(tokens[*token_count].value, "{", 2); (*token_count)++; }
        else if (ch == '}') { tokens[*token_count].type = TOKEN_RBRACE; strncpy(tokens[*token_count].value, "}", 2); (*token_count)++; }
        else if (ch == '[') { tokens[*token_count].type = TOKEN_LBRACKET; strncpy(tokens[*token_count].value, "[", 2); (*token_count)++; }
        else if (ch == ']') { tokens[*token_count].type = TOKEN_RBRACKET; strncpy(tokens[*token_count].value, "]", 2); (*token_count)++; }
        else if (ch == '(') { tokens[*token_count].type = TOKEN_LPAREN; strncpy(tokens[*token_count].value, "(", 2); (*token_count)++; } 
        else if (ch == ')') { tokens[*token_count].type = TOKEN_RPAREN; strncpy(tokens[*token_count].value, ")", 2); (*token_count)++; }
        else if (ch == '+') { tokens[*token_count].type = TOKEN_PLUS; strncpy(tokens[*token_count].value, "+", 2); (*token_count)++; }
        else if (ch == '-') { int next = fgetc(file); if (next == '>') { tokens[*token_count].type = TOKEN_ARROW; strncpy(tokens[*token_count].value, "->", 3); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_MINUS; strncpy(tokens[*token_count].value, "-", 2); } (*token_count)++; }
        else if (ch == '*') { tokens[*token_count].type = TOKEN_MUL; strncpy(tokens[*token_count].value, "*", 2); (*token_count)++; }
        else if (ch == '.') { tokens[*token_count].type = TOKEN_DOT; strncpy(tokens[*token_count].value, ".", 2); (*token_count)++; }
        else if (ch == ',') { tokens[*token_count].type = TOKEN_COMMA; strncpy(tokens[*token_count].value, ",", 2); (*token_count)++; }
        else if (isalpha(ch) || (unsigned char)ch >= 0x80) {
            int i = 0; tokens[*token_count].value[i++] = ch;
            while ((ch = fgetc(file)) != EOF && (isalnum(ch) || ch == '_' || (unsigned char)ch >= 0x80) && i < MAX_TOKEN_LEN - 1) tokens[*token_count].value[i++] = ch;
            if (ch != EOF) ungetc(ch, file); tokens[*token_count].value[i] = '\0';

            if (strcmp(tokens[*token_count].value, "Pro") == 0) tokens[*token_count].type = TOKEN_PRO;
            else if (strcmp(tokens[*token_count].value, "Vypiš") == 0) tokens[*token_count].type = TOKEN_VYPIS;
            else if (strcmp(tokens[*token_count].value, "Vypis") == 0) tokens[*token_count].type = TOKEN_VYPIS;
            else if (strcmp(tokens[*token_count].value, "Dokud") == 0) tokens[*token_count].type = TOKEN_DOKUD;
            else if (strcmp(tokens[*token_count].value, "Struktura") == 0) tokens[*token_count].type = TOKEN_STRUKTURA;
            else if (strcmp(tokens[*token_count].value, "Instance") == 0) tokens[*token_count].type = TOKEN_INSTANCE;
            else if (strcmp(tokens[*token_count].value, "Ukonci") == 0) tokens[*token_count].type = TOKEN_UKONCI;
            else if (strcmp(tokens[*token_count].value, "Pokracuj") == 0) tokens[*token_count].type = TOKEN_POKRACUJ;
            else if (strcmp(tokens[*token_count].value, "Metoda") == 0) tokens[*token_count].type = TOKEN_METODA;
            else if (strcmp(tokens[*token_count].value, "Volej") == 0) tokens[*token_count].type = TOKEN_VOLEJ;
            else if (strcmp(tokens[*token_count].value, "Vrat") == 0) tokens[*token_count].type = TOKEN_VRAT;
            else if (strcmp(tokens[*token_count].value, "Globalni") == 0) tokens[*token_count].type = TOKEN_GLOBALNI;
            else if (strcmp(tokens[*token_count].value, "Konstanta") == 0) tokens[*token_count].type = TOKEN_KONSTANTA;
            else if (strcmp(tokens[*token_count].value, "Velikost") == 0) tokens[*token_count].type = TOKEN_VELIKOST;
            else if (strcmp(tokens[*token_count].value, "Lokalni") == 0) tokens[*token_count].type = TOKEN_LOKALNI;
            else if (strcmp(tokens[*token_count].value, "Pokud") == 0) tokens[*token_count].type = TOKEN_POKUD;
            else if (strcmp(tokens[*token_count].value, "Jinak") == 0) tokens[*token_count].type = TOKEN_JINAK;
            else if (strcmp(tokens[*token_count].value, "Asm") == 0) tokens[*token_count].type = TOKEN_ASM;
            else if (strcmp(tokens[*token_count].value, "Externi") == 0) tokens[*token_count].type = TOKEN_EXTERNI;
            else if (strcmp(tokens[*token_count].value, "CtiZAdresu") == 0) tokens[*token_count].type = TOKEN_CTI_ADRESU;
            else tokens[*token_count].type = TOKEN_IDENTIFIER;
            (*token_count)++;
        } else { error_at(line, "Neznamy znak na vstupu lexeru!"); }
    }
    fclose(file);
}

typedef enum {
    AST_PROGRAM, AST_BLOCK, AST_METHOD, AST_VAR_DECL, AST_ASSIGN, 
    AST_EXPR, AST_IF, AST_WHILE, AST_FOR, AST_LOOP, AST_SYSCALL, AST_ASM_NODE,
    AST_MEM_WRITE, AST_MEM_READ, AST_ARRAY_READ, AST_ARRAY_ASSIGN,
    AST_MEMBER_READ, AST_MEMBER_ASSIGN, AST_PTR_MEMBER_READ, AST_PTR_MEMBER_ASSIGN, 
    AST_CALL, AST_RETURN, AST_BREAK, AST_CONTINUE, AST_EXTERN_DECL, AST_NOP, AST_PRINT
} AST_NodeType;

typedef struct AST_Node {
    AST_NodeType type; struct AST_Node *left; struct AST_Node *right; struct AST_Node *idx1; struct AST_Node *idx2;   
    struct AST_Node *alt; struct AST_Node **stmts; int stmt_count; char name[MAX_TOKEN_LEN]; char sub_name[MAX_TOKEN_LEN]; 
    int int_val; TokenType op; int line; int arg_count; int sym_start; int sym_end;
} AST_Node;

AST_Node* create_node(AST_NodeType type, int line) {
    AST_Node* node = (AST_Node*)custom_calloc(1, sizeof(AST_Node));
    node->type = type; node->line = line; return node;
}

AST_Node* parse_expression(Token tokens[], int *idx);

AST_Node* parse_primary(Token tokens[], int *idx) {
    AST_Node* expr = create_node(AST_EXPR, tokens[*idx].line);
    
    if (tokens[*idx].type == TOKEN_NUMBER) { expr->op = TOKEN_NUMBER; strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); (*idx)++; }
    else if (tokens[*idx].type == TOKEN_STRING) { expr->op = TOKEN_STRING; expr->int_val = tokens[*idx].str_id; (*idx)++; }
    else if (tokens[*idx].type == TOKEN_CTI_ADRESU) { expr->op = TOKEN_CTI_ADRESU; (*idx)++; expr->left = parse_expression(tokens, idx); }
    else if (tokens[*idx].type == TOKEN_VELIKOST) { expr->op = TOKEN_VELIKOST; (*idx)++; if (tokens[*idx].type == TOKEN_LPAREN) (*idx)++; strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); (*idx)++; if (tokens[*idx].type == TOKEN_RPAREN) (*idx)++; }
    else if (tokens[*idx].type == TOKEN_VOLEJ) {
        expr->type = AST_CALL; (*idx)++;
        strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); (*idx)++;
        if (tokens[*idx].type == TOKEN_LPAREN) {
            (*idx)++; expr->stmts = custom_malloc(20 * sizeof(AST_Node*)); expr->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) {
                expr->stmts[expr->stmt_count++] = parse_expression(tokens, idx);
                if (tokens[*idx].type == TOKEN_COMMA) (*idx)++;
            }
            (*idx)++;
        }
    }
    else if (tokens[*idx].type == TOKEN_LPAREN) { 
        (*idx)++; 
        expr = parse_expression(tokens, idx); 
        if (tokens[*idx].type == TOKEN_RPAREN) (*idx)++; else error_at(tokens[*idx].line, "Chybi uzaviraci zavorka ')'"); 
    }
    else if (tokens[*idx].type == TOKEN_IDENTIFIER) {
        if (tokens[*idx+1].type == TOKEN_LPAREN) {
            expr->type = AST_CALL; strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); *idx += 2;
            expr->stmts = custom_malloc(20 * sizeof(AST_Node*)); expr->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) { expr->stmts[expr->stmt_count++] = parse_expression(tokens, idx); if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; }
            (*idx)++;
        } 
        else if (tokens[*idx+1].type == TOKEN_ARROW) {
            expr->type = AST_PTR_MEMBER_READ; strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); strncpy(expr->sub_name, tokens[*idx+2].value, MAX_TOKEN_LEN-1);
            check_ptr_member_access(expr->name, expr->sub_name, tokens[*idx].line);
            *idx += 3;
        } else { expr->op = TOKEN_IDENTIFIER; strncpy(expr->name, tokens[*idx].value, MAX_TOKEN_LEN-1); (*idx)++; }
    } else { error_at(tokens[*idx].line, "Neocekavany token ve vyrazu!"); }
    return expr;
}

AST_Node* parse_unary(Token tokens[], int *idx) {
    if (tokens[*idx].type == TOKEN_MINUS) { AST_Node* node = create_node(AST_EXPR, tokens[*idx].line); node->op = TOKEN_MINUS; (*idx)++; node->left = parse_unary(tokens, idx); return node; } 
    return parse_primary(tokens, idx);
}
AST_Node* parse_term(Token tokens[], int *idx) {
    AST_Node* node = parse_unary(tokens, idx);
    while (tokens[*idx].type == TOKEN_MUL || tokens[*idx].type == TOKEN_DIV) { AST_Node* bin = create_node(AST_EXPR, tokens[*idx].line); bin->op = tokens[*idx].type; (*idx)++; bin->left = node; bin->right = parse_unary(tokens, idx); node = bin; }
    return node;
}
AST_Node* parse_arithmetic(Token tokens[], int *idx) {
    AST_Node* node = parse_term(tokens, idx);
    while (tokens[*idx].type == TOKEN_PLUS || tokens[*idx].type == TOKEN_MINUS) { AST_Node* bin = create_node(AST_EXPR, tokens[*idx].line); bin->op = tokens[*idx].type; (*idx)++; bin->left = node; bin->right = parse_term(tokens, idx); node = bin; }
    return node;
}
AST_Node* parse_bitwise(Token tokens[], int *idx) {
    AST_Node* node = parse_arithmetic(tokens, idx);
    while (tokens[*idx].type == TOKEN_AND || tokens[*idx].type == TOKEN_OR || tokens[*idx].type == TOKEN_XOR) { AST_Node* bin = create_node(AST_EXPR, tokens[*idx].line); bin->op = tokens[*idx].type; (*idx)++; bin->left = node; bin->right = parse_arithmetic(tokens, idx); node = bin; }
    return node;
}
AST_Node* parse_relational(Token tokens[], int *idx) {
    AST_Node* node = parse_bitwise(tokens, idx);
    while (tokens[*idx].type == TOKEN_EQEQ || tokens[*idx].type == TOKEN_NEQ || tokens[*idx].type == TOKEN_LESS || tokens[*idx].type == TOKEN_GREATER || tokens[*idx].type == TOKEN_LESSEQ || tokens[*idx].type == TOKEN_GREATEREQ) { 
        AST_Node* bin = create_node(AST_EXPR, tokens[*idx].line); 
        bin->op = tokens[*idx].type; 
        (*idx)++; 
        bin->left = node; 
        bin->right = parse_bitwise(tokens, idx); 
        node = bin; 
    }
    return node;
}
AST_Node* parse_logical(Token tokens[], int *idx) {
    AST_Node* node = parse_relational(tokens, idx);
    while (tokens[*idx].type == TOKEN_AND_LOGICAL || tokens[*idx].type == TOKEN_OR_LOGICAL) {
        AST_Node* bin = create_node(AST_EXPR, tokens[*idx].line); 
        bin->op = tokens[*idx].type; 
        (*idx)++; 
        bin->left = node; 
        bin->right = parse_relational(tokens, idx); 
        node = bin;
    }
    return node;
}
AST_Node* parse_expression(Token tokens[], int *idx) { return parse_logical(tokens, idx); }

AST_Node* parse_block(Token tokens[], int *idx, int step);

AST_Node* parse_statement(Token tokens[], int *idx, int step) {
    int i = *idx; AST_Node* stmt = NULL;

    if (tokens[i].type == TOKEN_LOKALNI) {
        stmt = create_node(AST_VAR_DECL, tokens[i].line); strncpy(stmt->name, tokens[i+1].value, MAX_TOKEN_LEN-1); *idx = i + 2;
        char type_name[64] = {0};
        if (tokens[*idx].type == TOKEN_COLON) { (*idx)++; strncpy(type_name, tokens[*idx].value, 63); (*idx)++; }
        if (tokens[*idx].type == TOKEN_EQ) (*idx)++;
        stmt->right = parse_expression(tokens, idx);
        add_local_symbol(stmt->name, step, 1, 1, type_name[0] ? type_name : NULL);
    }
    else if (tokens[i].type == TOKEN_IDENTIFIER) {
        if (tokens[i+1].type == TOKEN_LPAREN) { 
            stmt = create_node(AST_CALL, tokens[i].line); strncpy(stmt->name, tokens[i].value, MAX_TOKEN_LEN-1); *idx = i + 2;
            stmt->stmts = custom_malloc(20 * sizeof(AST_Node*)); stmt->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) { stmt->stmts[stmt->stmt_count++] = parse_expression(tokens, idx); if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; }
            (*idx)++; 
        }
        else if (tokens[i+1].type == TOKEN_EQ) {
            stmt = create_node(AST_ASSIGN, tokens[i].line); strncpy(stmt->name, tokens[i].value, MAX_TOKEN_LEN-1); *idx = i + 2;
            stmt->right = parse_expression(tokens, idx);
        } else if (tokens[i+1].type == TOKEN_ARROW) {
            if (tokens[i+3].type == TOKEN_EQ) {
                stmt = create_node(AST_PTR_MEMBER_ASSIGN, tokens[i].line); strncpy(stmt->name, tokens[i].value, MAX_TOKEN_LEN-1); 
                strncpy(stmt->sub_name, tokens[i+2].value, MAX_TOKEN_LEN-1); *idx = i + 4;
                check_ptr_member_access(stmt->name, stmt->sub_name, tokens[i].line);
                stmt->right = parse_expression(tokens, idx);
            } else if (tokens[i+3].type == TOKEN_LBRACKET) {
                stmt = create_node(AST_ARRAY_ASSIGN, tokens[i].line); strncpy(stmt->name, tokens[i].value, MAX_TOKEN_LEN-1);
                Symbol *sym_arr = find_symbol(tokens[i].value);
                if (sym_arr) stmt->int_val = get_member_offset(sym_arr->type_name, tokens[i+2].value, step, tokens[i].line);
                *idx = i + 4;
                stmt->left = parse_expression(tokens, idx); 
                if (tokens[*idx].type == TOKEN_RBRACKET) (*idx)++;
                if (tokens[*idx].type == TOKEN_EQ) (*idx)++;
                stmt->right = parse_expression(tokens, idx); 
            } else {
                error_at(tokens[i].line, "Neplatny zapis pro strukturu - chybi prirazeni!");
            }
        }
        else { error_at(tokens[i].line, "Samostatny identifikator neni platny prikaz!"); }
    }
    else if (tokens[i].type == TOKEN_POKUD) {
        stmt = create_node(AST_IF, tokens[i].line); *idx = i + 1;
        if (tokens[*idx].type == TOKEN_LPAREN) (*idx)++; stmt->left = parse_expression(tokens, idx); if (tokens[*idx].type == TOKEN_RPAREN) (*idx)++;
        if (tokens[*idx].type == TOKEN_LBRACE) { (*idx)++; stmt->right = parse_block(tokens, idx, step); } else stmt->right = parse_statement(tokens, idx, step);
        
        if (tokens[*idx].type == TOKEN_JINAK) {
            (*idx)++;
            if (tokens[*idx].type == TOKEN_LBRACE) {
                (*idx)++; stmt->alt = parse_block(tokens, idx, step);
            } else {
                stmt->alt = parse_statement(tokens, idx, step);
            }
        }
    }
    else if (tokens[i].type == TOKEN_DOKUD) {
        stmt = create_node(AST_WHILE, tokens[i].line); *idx = i + 1; 
        if (tokens[*idx].type == TOKEN_LPAREN) (*idx)++; stmt->left = parse_expression(tokens, idx); if (tokens[*idx].type == TOKEN_RPAREN) (*idx)++;
        if (tokens[*idx].type == TOKEN_LBRACE) { (*idx)++; stmt->right = parse_block(tokens, idx, step); } else stmt->right = parse_statement(tokens, idx, step);
    }
    else if (tokens[i].type == TOKEN_ASM) { stmt = create_node(AST_ASM_NODE, tokens[i].line); strncpy(stmt->name, tokens[i+1].value, MAX_TOKEN_LEN-1); *idx = i + 2; }
    else if (tokens[i].type == TOKEN_VOLEJ) { 
        stmt = create_node(AST_CALL, tokens[i].line); strncpy(stmt->name, tokens[i+1].value, MAX_TOKEN_LEN-1); *idx = i + 2;
        if (tokens[*idx].type == TOKEN_LPAREN) {
            (*idx)++; stmt->stmts = custom_malloc(20 * sizeof(AST_Node*)); stmt->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) { stmt->stmts[stmt->stmt_count++] = parse_expression(tokens, idx); if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; }
            (*idx)++;
        }
    }
    else if (tokens[i].type == TOKEN_VRAT) { stmt = create_node(AST_RETURN, tokens[i].line); *idx = i + 1; if (tokens[*idx].type != TOKEN_RBRACE) stmt->left = parse_expression(tokens, idx); }
    else if (tokens[i].type == TOKEN_UKONCI) { stmt = create_node(AST_BREAK, tokens[i].line); *idx = i + 1; }
    else if (tokens[i].type == TOKEN_POKRACUJ) { stmt = create_node(AST_CONTINUE, tokens[i].line); *idx = i + 1; }
    else if (tokens[i].type == TOKEN_VYPIS) { stmt = create_node(AST_PRINT, tokens[i].line); *idx = i + 1; stmt->left = parse_expression(tokens, idx); }
    else { error_at(tokens[i].line, "Neocekavany prikaz!"); } 

    return stmt ? stmt : create_node(AST_NOP, tokens[i].line);
}

AST_Node* parse_block(Token tokens[], int *idx, int step) {
    int prev_sym_count = sym_count; int prev_offset = current_local_offset;
    AST_Node* block = create_node(AST_BLOCK, tokens[*idx].line); block->stmts = custom_malloc(200 * sizeof(AST_Node*)); block->stmt_count = 0;
    while (tokens[*idx].type != TOKEN_RBRACE && tokens[*idx].type != TOKEN_EOF) { AST_Node* stmt = parse_statement(tokens, idx, step); if (stmt && stmt->type != AST_NOP) block->stmts[block->stmt_count++] = stmt; } 
    (*idx)++; /* sym_count se jiz neresetuje - lokalni symboly musi zustat viditelne pro pozdejsi generovani ASM */
    return block;
}

AST_Node* parse_program(Token tokens[], int token_count, int target_os) {
    AST_Node* root = create_node(AST_PROGRAM, 1); root->stmts = custom_malloc(1000 * sizeof(AST_Node*)); root->stmt_count = 0;
    int idx = 0; int step = 8;
    while (idx < token_count && tokens[idx].type != TOKEN_EOF) {
        if (tokens[idx].type == TOKEN_STRUKTURA) {
            idx++; strncpy(struct_registry[struct_count].name, tokens[idx++].value, 63); idx++;
            struct_registry[struct_count].count = 0; int current_offset = 0;
            while (tokens[idx].type == TOKEN_IDENTIFIER) { 
                strncpy(struct_registry[struct_count].members[struct_registry[struct_count].count], tokens[idx++].value, 63); 
                int mem_size = step; int is_arr = 0; if (tokens[idx].type == TOKEN_LBRACKET) { idx++; mem_size = atoi(tokens[idx].value) * step; idx += 2; is_arr = 1; }
                struct_registry[struct_count].member_offsets[struct_registry[struct_count].count] = current_offset;
                struct_registry[struct_count].member_is_array[struct_registry[struct_count].count] = is_arr;
                current_offset += mem_size; struct_registry[struct_count].count++;
            }
            struct_registry[struct_count].total_bytes = current_offset; idx++; struct_count++;
        }
        else if (tokens[idx].type == TOKEN_KONSTANTA) {
            idx++; char *name = tokens[idx++].value; idx++; int val = atoi(tokens[idx++].value);
            strncpy(sym_table[sym_count].name, name, MAX_TOKEN_LEN-1); sym_table[sym_count].is_global = 1; sym_table[sym_count].is_const = 1; sym_table[sym_count].const_val = val; sym_count++;
        }
        else if (tokens[idx].type == TOKEN_GLOBALNI) {
            idx++; char *name = tokens[idx++].value; idx++; char *val = tokens[idx++].value;
            strncpy(sym_table[sym_count].name, name, MAX_TOKEN_LEN-1); sym_table[sym_count].is_global = 1; sym_table[sym_count].is_const = 0; sym_table[sym_count].dim1 = 0; strncpy(sym_table[sym_count].init_str, val, 63); sym_count++;
        }
        else if (tokens[idx].type == TOKEN_EXTERNI) {
            AST_Node* ext = create_node(AST_EXTERN_DECL, tokens[idx].line); idx++; strncpy(ext->name, tokens[idx].value, MAX_TOKEN_LEN-1); idx++; root->stmts[root->stmt_count++] = ext;
        }
        else if (tokens[idx].type == TOKEN_METODA) {
            AST_Node* method = create_node(AST_METHOD, tokens[idx].line); strncpy(method->name, tokens[idx+1].value, MAX_TOKEN_LEN-1); idx += 2;
            current_local_offset = 0; int arg_idx = 0; method->sym_start = sym_count;
            if (tokens[idx].type == TOKEN_LPAREN) {
                idx++;
                while (tokens[idx].type != TOKEN_RPAREN && tokens[idx].type != TOKEN_EOF) {
                    if (tokens[idx].type == TOKEN_IDENTIFIER) {
                        strncpy(sym_table[sym_count].name, tokens[idx].value, MAX_TOKEN_LEN-1); sym_table[sym_count].is_global = 0; sym_table[sym_count].offset = -((arg_idx + 2) * step); sym_table[sym_count].type_name[0] = '\0'; sym_count++; arg_idx++; idx++;
                        
                        // Zde ošetřujeme situaci "uzel : AST_Node"
                        if (tokens[idx].type == TOKEN_COLON) {
                            idx++; // přeskočí ':'
                            if (tokens[idx].type == TOKEN_IDENTIFIER) {
                                strncpy(sym_table[sym_count-1].type_name, tokens[idx].value, 63);
                                idx++; // přeskočí 'AST_Node'
                            }
                        }
                        
                        if (tokens[idx].type == TOKEN_COMMA) idx++;
                    } else {
                        error_at(tokens[idx].line, "Neocekavany token v definici parametru metody!");
                    }
                }
                idx++; 
            }
            if (tokens[idx].type == TOKEN_LBRACE) idx++; 
            method->right = parse_block(tokens, &idx, step); 
            method->sym_end = sym_count;
            method->int_val = current_local_offset > 256 ? current_local_offset : 256; 
            method->arg_count = arg_idx;
            root->stmts[root->stmt_count++] = method;
        } else {
            AST_Node* stmt = parse_statement(tokens, &idx, step);
            if (stmt && stmt->type != AST_NOP) root->stmts[root->stmt_count++] = stmt;
        }
    }
    return root;
}

int label_counter = 0;

void generate_expr(FILE *out, AST_Node *expr, int is_k, const char *ax, const char *bx, const char *bp, int step) {
    if (!expr) return;
    if (expr->op == TOKEN_NUMBER) { fprintf(out, "    mov %s, %s\n", ax, expr->name); }
    else if (expr->op == TOKEN_STRING) { fprintf(out, "    lea %s, [%s str%d]\n", ax, is_k ? "" : "rel", expr->int_val); }
    else if (expr->op == TOKEN_VELIKOST) { int size = get_struct_bytes(expr->name, step); fprintf(out, "    mov %s, %d\n", ax, size); }
    else if (expr->op == TOKEN_IDENTIFIER) {
        Symbol *s = find_symbol(expr->name);
        if (!s) error_at(expr->line, "Nedeklarovana promenna!");
        if (s->is_const) fprintf(out, "    mov %s, %d\n", ax, s->const_val);
        else if (s->is_global) fprintf(out, "    mov %s, [%s gvar_%s]\n", ax, is_k ? "" : "rel", s->name);
        else fprintf(out, "    mov %s, [%s %s %d]\n", ax, bp, O_SIGN(s->offset), O_ABS(s->offset));
    }
    else if (expr->type == AST_PTR_MEMBER_READ) {
        Symbol *s = find_symbol(expr->name);
        if (!s) error_at(expr->line, "Nedeklarovana promenna!");
        int real_offset = get_member_offset(s->type_name, expr->sub_name, step, expr->line);
        int is_arr = get_member_is_array(s->type_name, expr->sub_name);
        if (s->is_global) fprintf(out, "    mov %s, [%s gvar_%s]\n", ax, is_k ? "" : "rel", s->name);
        else fprintf(out, "    mov %s, [%s %s %d]\n", ax, bp, O_SIGN(s->offset), O_ABS(s->offset));
        if (is_arr) {
            if (real_offset != 0) fprintf(out, "    add %s, %d\n", ax, real_offset);
        }
        else if (real_offset == 0) fprintf(out, "    mov %s, [%s]\n", ax, ax);
        else fprintf(out, "    mov %s, [%s + %d]\n", ax, ax, real_offset);
    }
    else if (expr->op == TOKEN_CTI_ADRESU) { generate_expr(out, expr->left, is_k, ax, bx, bp, step); fprintf(out, "    mov %s, [%s]\n", ax, ax); }
    else if (expr->type == AST_CALL) { 
        for (int j = expr->stmt_count - 1; j >= 0; j--) {
            generate_expr(out, expr->stmts[j], is_k, ax, bx, bp, step);
            fprintf(out, "    push %s\n", is_k?"eax":"rax");
        }
        
        if (expr->stmt_count > 0) fprintf(out, "    pop rcx\n");
        if (expr->stmt_count > 1) fprintf(out, "    pop rdx\n");
        if (expr->stmt_count > 2) fprintf(out, "    pop r8\n");
        if (expr->stmt_count > 3) fprintf(out, "    pop r9\n");
        
        fprintf(out, "    sub rsp, 32\n"); 
        fprintf(out, "    call %s\n", expr->name);
        fprintf(out, "    add rsp, 32\n"); 
        if (!is_k && (strcmp(expr->name, "fgetc") == 0 || strcmp(expr->name, "getchar") == 0 || strcmp(expr->name, "fputc") == 0 || strcmp(expr->name, "putchar") == 0 || strcmp(expr->name, "strcmp") == 0 || strcmp(expr->name, "system") == 0)) {
            fprintf(out, "    cdqe\n");
        }
        
        if (expr->stmt_count > 4) {
            fprintf(out, "    add %s, %d\n", is_k?"esp":"rsp", (expr->stmt_count - 4) * step);
        }
    }
    else if (expr->op == TOKEN_MINUS && expr->left && !expr->right) {
        generate_expr(out, expr->left, is_k, ax, bx, bp, step);
        fprintf(out, "    neg %s\n", ax);
    }
    else if (expr->left && expr->right) {
        generate_expr(out, expr->right, is_k, ax, bx, bp, step); fprintf(out, "    push %s\n", is_k?"eax":"rax");
        generate_expr(out, expr->left, is_k, ax, bx, bp, step); fprintf(out, "    pop %s\n", bx); 
        
        if (expr->op == TOKEN_PLUS) fprintf(out, "    add %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_MINUS) fprintf(out, "    sub %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_MUL) fprintf(out, "    imul %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_EQEQ) { fprintf(out, "    cmp %s, %s\n    sete al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_NEQ)  { fprintf(out, "    cmp %s, %s\n    setne al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_LESS) { fprintf(out, "    cmp %s, %s\n    setl al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_GREATER) { fprintf(out, "    cmp %s, %s\n    setg al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_LESSEQ) { fprintf(out, "    cmp %s, %s\n    setle al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_GREATEREQ) { fprintf(out, "    cmp %s, %s\n    setge al\n    movzx %s, al\n", ax, bx, ax); }
        else if (expr->op == TOKEN_AND || expr->op == TOKEN_AND_LOGICAL) { fprintf(out, "    and %s, %s\n", ax, bx); }
        else if (expr->op == TOKEN_OR || expr->op == TOKEN_OR_LOGICAL) { fprintf(out, "    or %s, %s\n", ax, bx); }
        else if (expr->op == TOKEN_XOR) { fprintf(out, "    xor %s, %s\n", ax, bx); }
    }
}

void generate_ast(FILE *out, AST_Node *node, int target_os, int loop_start, int loop_end) {
    if (!node) return;
    int is_k = (target_os == OS_KERNEL); const char *ax = is_k ? "eax" : "rax", *bx = is_k ? "ebx" : "rbx", *bp = is_k ? "ebp" : "rbp", *word = is_k ? "dword" : "qword"; int step = is_k ? 4 : 8;

    if (node->type == AST_VAR_DECL) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step); Symbol *s = find_symbol(node->name);
        fprintf(out, "    mov %s [%s %s %d], %s\n", word, bp, O_SIGN(s->offset), O_ABS(s->offset), ax);
    }
    else if (node->type == AST_ASSIGN) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step); Symbol *s = find_symbol(node->name);
        if (!s) error_at(node->line, "Prirazeni do nedeklarovane promenne!");
        if (s->is_global) fprintf(out, "    mov %s [%s gvar_%s], %s\n", word, is_k ? "" : "rel", s->name, ax);
        else fprintf(out, "    mov %s [%s %s %d], %s\n", word, bp, O_SIGN(s->offset), O_ABS(s->offset), ax);
    }
    else if (node->type == AST_PTR_MEMBER_ASSIGN) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step); Symbol *s = find_symbol(node->name);
        if (!s || s->type_name[0] == '\0') error_at(node->line, "Promenna chybi nebo nema dany typ!");
        int real_offset = get_member_offset(s->type_name, node->sub_name, step, node->line);
        fprintf(out, "    push %s\n", is_k?"eax":"rax"); 
        if (s->is_global) fprintf(out, "    mov %s, [%s gvar_%s]\n", bx, is_k ? "" : "rel", s->name);
        else fprintf(out, "    mov %s, [%s %s %d]\n", bx, bp, O_SIGN(s->offset), O_ABS(s->offset)); 
        fprintf(out, "    pop %s\n", is_k?"eax":"rax"); 
        if (real_offset == 0) fprintf(out, "    mov [%s], %s\n", bx, ax); else fprintf(out, "    mov [%s + %d], %s\n", bx, real_offset, ax);
    }
    else if (node->type == AST_ARRAY_ASSIGN) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step); fprintf(out, "    push %s\n", is_k?"eax":"rax");
        generate_expr(out, node->left, is_k, ax, bx, bp, step); fprintf(out, "    push %s\n", is_k?"eax":"rax");
        Symbol *s = find_symbol(node->name);
        if (s) {
            if (s->is_global) fprintf(out, "    mov %s, qword [%s gvar_%s]\n", bx, is_k?"":"rel", s->name);
            else fprintf(out, "    mov %s, qword [%s %s %d]\n", bx, bp, O_SIGN(s->offset), O_ABS(s->offset));
            if (node->int_val != 0) fprintf(out, "    add %s, %d\n", bx, node->int_val);
            fprintf(out, "    pop rcx\n    add %s, rcx\n    pop rax\n    mov byte [%s], al\n", bx, bx);
        }
    }
   else if (node->type == AST_IF || node->type == AST_WHILE) {
        int lbl = label_counter++; 
        if (node->type == AST_WHILE) fprintf(out, ".L_start_%d:\n", lbl);
        
        generate_expr(out, node->left, is_k, ax, bx, bp, step); 
        fprintf(out, "    cmp %s, 0\n    je .L_end_%d\n", ax, lbl);
        
        // OPRAVA ZDE: Rozlišení kontextu podle typu uzlu
        if (node->type == AST_WHILE) {
            generate_ast(out, node->right, target_os, lbl, lbl); 
        } else {
            // IF nesmí přepsat loop_start a loop_end!
            generate_ast(out, node->right, target_os, loop_start, loop_end); 
        }
        
        if (node->type == AST_IF && node->alt) { 
            fprintf(out, "    jmp .L_else_end_%d\n.L_end_%d:\n", lbl, lbl); 
            generate_ast(out, node->alt, target_os, loop_start, loop_end); 
            fprintf(out, ".L_else_end_%d:\n", lbl); 
        } 
        else { 
            if (node->type == AST_WHILE) { 
                fprintf(out, ".L_cont_%d:\n", lbl); 
                fprintf(out, "    jmp .L_start_%d\n", lbl); 
            } 
            fprintf(out, ".L_end_%d:\n", lbl); 
        }
    }
    else if (node->type == AST_BLOCK) { for (int i = 0; i < node->stmt_count; i++) generate_ast(out, node->stmts[i], target_os, loop_start, loop_end); }
    else if (node->type == AST_PROGRAM) { for (int i = 0; i < node->stmt_count; i++) { if (node->stmts[i]->type != AST_METHOD && node->stmts[i]->type != AST_EXTERN_DECL) generate_ast(out, node->stmts[i], target_os, -1, -1); } }
    else if (node->type == AST_PRINT) {
        generate_expr(out, node->left, is_k, ax, bx, bp, step);
        fprintf(out, "    mov rdx, rax\n    lea rcx, [rel fmt_int]\n    sub rsp, 32\n    call printf\n    add rsp, 32\n");
    }
    else if (node->type == AST_ASM_NODE) { fprintf(out, "    %s\n", node->name); }
    else if (node->type == AST_CALL) { 
        for (int j = node->stmt_count - 1; j >= 0; j--) { 
            generate_expr(out, node->stmts[j], is_k, ax, bx, bp, step); 
            fprintf(out, "    push %s\n", is_k?"eax":"rax"); 
        }
        
        if (node->stmt_count > 0) fprintf(out, "    pop rcx\n");
        if (node->stmt_count > 1) fprintf(out, "    pop rdx\n");
        if (node->stmt_count > 2) fprintf(out, "    pop r8\n");
        if (node->stmt_count > 3) fprintf(out, "    pop r9\n");
        
        fprintf(out, "    sub rsp, 32\n");
        fprintf(out, "    call %s\n", node->name); 
        fprintf(out, "    add rsp, 32\n");
        
        if (node->stmt_count > 4) {
            fprintf(out, "    add %s, %d\n", is_k?"esp":"rsp", (node->stmt_count - 4) * step);
        }
    }
    else if (node->type == AST_RETURN) { if (node->left) generate_expr(out, node->left, is_k, ax, bx, bp, step); fprintf(out, "    mov %s, %s\n    pop %s\n    ret\n", is_k?"esp":"rsp", bp, bp); }
    else if (node->type == AST_BREAK) { fprintf(out, "    jmp .L_end_%d\n", loop_end); }
    else if (node->type == AST_CONTINUE) { fprintf(out, "    jmp .L_cont_%d\n", loop_start); }
}

void generate_asm_file(AST_Node* ast, Token tokens[], int token_count, const char *out_filename, int target_os) {
    FILE *out = fopen(out_filename, "w"); 
    if (!out) { printf("Chyba: Nelze zapsat ASM!\n"); fflush(stdout); exit(1); }
    int is_k = (target_os == OS_KERNEL);

    add_global_symbol("sys_argc"); add_global_symbol("sys_argv");
    fprintf(out, "section .data\n    fmt_int db \"%%d\", 10, 0\n    fmt_scanf db \"%%d\", 0\n    gvar_sys_argc dq 0\n    gvar_sys_argv dq 0\n"); 
    for (int i = 0; i < token_count; i++) {
    if (tokens[i].type == TOKEN_STRING) {
        fprintf(out, "    str%d db ", tokens[i].str_id);
        for (int j = 0; tokens[i].value[j] != '\0'; j++) {
            fprintf(out, "%d, ", (unsigned char)tokens[i].value[j]);
        }
        fprintf(out, "0\n"); 
    }
}
    for (int i = 0; i < sym_count; i++) { if (sym_table[i].is_global && !sym_table[i].is_const && sym_table[i].dim1 == 0 && strcmp(sym_table[i].name, "sys_argc") != 0 && strcmp(sym_table[i].name, "sys_argv") != 0) { fprintf(out, "    gvar_%s %s %s\n", sym_table[i].name, is_k?"dd":"dq", sym_table[i].init_str); } }
    fprintf(out, "\nsection .bss\nalign 16\n");
    for (int i = 0; i < sym_count; i++) { if (sym_table[i].is_global && sym_table[i].dim1 > 0) { fprintf(out, "    gvar_%s resb %d\n", sym_table[i].name, sym_table[i].dim1 * (is_k?4:8)); } }
    fprintf(out, "\nsection .text\n");
    for (int i = 0; i < ast->stmt_count; i++) { if (ast->stmts[i]->type == AST_EXTERN_DECL) fprintf(out, "    extern %s\n", ast->stmts[i]->name); }

    fprintf(out, "    global main\n    extern printf\n    extern exit\n    extern fopen\n    extern fclose\n    extern fgetc\n\nmain:\n    push rbp\n    mov rbp, rsp\n    sub rsp, 8192\n");
    fprintf(out, "    mov [rel gvar_sys_argc], rcx\n    mov [rel gvar_sys_argv], rdx\n");
    
    current_local_offset = 0;
    generate_ast(out, ast, target_os, -1, -1); 

    fprintf(out, "\n    xor rax, rax\n    mov rsp, rbp\n    pop rbp\n");
    fprintf(out, "    sub rsp, 40\n    xor rcx, rcx\n    call exit\n");
    
    for (int i = 0; i < ast->stmt_count; i++) {
        if (ast->stmts[i]->type == AST_METHOD) {
            int req_stack = ast->stmts[i]->int_val; int aligned_stack = (req_stack + 15) & ~15;
            fprintf(out, "%s:\n    push %s\n    mov %s, %s\n    sub %s, %d\n", ast->stmts[i]->name, is_k?"ebp":"rbp", is_k?"ebp":"rbp", is_k?"esp":"rsp", is_k?"esp":"rsp", aligned_stack);
            int ac = ast->stmts[i]->arg_count;
            const char *pregs[4] = {"rcx","rdx","r8","r9"};
            for (int p = 0; p < ac && p < 4; p++) fprintf(out, "    mov [%s + %d], %s\n", is_k?"ebp":"rbp", 16 + p*8, pregs[p]);
            codegen_method_sym_start = ast->stmts[i]->sym_start;
            codegen_method_sym_end = ast->stmts[i]->sym_end;
            generate_ast(out, ast->stmts[i]->right, target_os, -1, -1);
            codegen_method_sym_start = -1;
            codegen_method_sym_end = 1000000;
            fprintf(out, "    mov %s, %s\n    pop %s\n    ret\n\n", is_k?"esp":"rsp", is_k?"ebp":"rbp", is_k?"ebp":"rbp");
        }
    }
    fclose(out);
}

void compile_executable(const char *asm_file, int target_os, const char *output_file) {
    char cmd[512]; printf("Generuji '%s'...\n", output_file);
    sprintf(cmd, "nasm -f win64 %s -o docasny.obj", asm_file); system(cmd);
    sprintf(cmd, "gcc docasny.obj -o %s.exe", output_file); system(cmd);
    system("del docasny.obj"); printf("Hotovo: %s.exe\n", output_file);
}

int main(int argc, char *argv[]) {
    int target_os = OS_WINDOWS; char *input_file = "ahoj.txt"; char *output_file = "program"; int pos_args = 0;
    for (int i = 1; i < argc; i++) {
        if (strncmp(argv[i], "--", 2) == 0) { if (strcmp(argv[i], "--kernel") == 0) target_os = OS_KERNEL; else if (strcmp(argv[i], "--linux") == 0) target_os = OS_LINUX; } 
        else { if (pos_args == 0) input_file = argv[i]; else if (pos_args == 1) output_file = argv[i]; pos_args++; }
    }
    
    Token *tokens = (Token*)malloc(MAX_TOKENS * sizeof(Token));
    if (tokens == NULL) { printf("Chyba: Nedostatek pameti pro tokeny!\n"); fflush(stdout); return 1; }
    
    int token_count = 0; tokenize(input_file, tokens, &token_count);
    tokens[token_count].type = TOKEN_EOF; tokens[token_count].line = 0;
    
    AST_Node* ast = parse_program(tokens, token_count, target_os);
    char asm_name[256]; sprintf(asm_name, "%s.asm", output_file);
    generate_asm_file(ast, tokens, token_count, asm_name, target_os); compile_executable(asm_name, target_os, output_file);
    
    free(tokens);
    return 0;
}