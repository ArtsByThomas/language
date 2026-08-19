#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKENS 4000
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

void* custom_malloc(size_t size) {
    size_t remainder = size % 8;
    if (remainder != 0) size += (8 - remainder);
    if (memory_offset + size > MEMORY_POOL_SIZE) { printf("Chyba: Nedostatek pameti!\n"); exit(1); }
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

// --- 1. TOKENY ---
typedef enum {
    TOKEN_VYPIS, TOKEN_VYPIS_HODNOTU, TOKEN_CTI_HODNOTU,
    TOKEN_OPAKUJ, TOKEN_METODA, TOKEN_VOLEJ, TOKEN_VRAT,
    TOKEN_DOKUD, TOKEN_UKONCI, TOKEN_POKRACUJ,
    TOKEN_GLOBALNI, TOKEN_LOKALNI, TOKEN_LOKALNI_POLE,
    TOKEN_STRUKTURA, TOKEN_INSTANCE, TOKEN_DOT,
    TOKEN_POKUD, TOKEN_JINAK,
    TOKEN_ASM, TOKEN_ZAPIS_ADRESU, TOKEN_CTI_ADRESU,
    TOKEN_OTEVRI_SOUBOR, TOKEN_ZAVRI_SOUBOR, TOKEN_CTI_ZNAK, TOKEN_ZAPIS_ZNAK,
    TOKEN_CTI_BYTE, TOKEN_ZAPIS_BYTE, 
    TOKEN_STRING, TOKEN_NUMBER, TOKEN_IDENTIFIER,
    TOKEN_LBRACE, TOKEN_RBRACE, TOKEN_LBRACKET, TOKEN_RBRACKET, 
    TOKEN_LPAREN, TOKEN_RPAREN, 
    TOKEN_EQ, TOKEN_EQEQ, TOKEN_NEQ, TOKEN_LESS, TOKEN_GREATER, TOKEN_COLON,
    TOKEN_PLUS, TOKEN_MINUS, TOKEN_MUL, TOKEN_DIV,
    TOKEN_AND, TOKEN_OR, TOKEN_XOR, TOKEN_SHL, TOKEN_SHR,
    TOKEN_AMPER, TOKEN_COMMA, TOKEN_UNKNOWN, TOKEN_EOF
} TokenType;

typedef struct { TokenType type; char value[MAX_TOKEN_LEN]; int str_id; } Token;
typedef struct { char name[MAX_TOKEN_LEN]; int is_global; int offset; int dim1, dim2; char type_name[64]; } Symbol;

typedef struct { char name[64]; char members[20][64]; int count; } StructDef;
StructDef struct_registry[20];
int struct_count = 0;

int get_struct_size(const char* name) {
    for(int i=0; i<struct_count; i++) if(strcmp(struct_registry[i].name, name)==0) return struct_registry[i].count;
    return 1;
}
int get_member_offset(const char* s_name, const char* m_name, int step) {
    for(int i=0; i<struct_count; i++) {
        if(strcmp(struct_registry[i].name, s_name)==0) {
            for(int j=0; j<struct_registry[i].count; j++) {
                if(strcmp(struct_registry[i].members[j], m_name)==0) return j * step;
            }
        }
    }
    printf("Chyba: Vlastnost '%s' ve strukture '%s' neexistuje!\n", m_name, s_name); exit(1);
}

Symbol sym_table[200]; int sym_count = 0; int current_local_offset = 0;

void add_global_symbol(const char *name) { strcpy(sym_table[sym_count].name, name); sym_table[sym_count].is_global = 1; sym_count++; }
void add_local_symbol(const char *name, int step, int d1, int d2, const char* type_name) {
    strcpy(sym_table[sym_count].name, name); sym_table[sym_count].is_global = 0;
    sym_table[sym_count].dim1 = d1; sym_table[sym_count].dim2 = d2;
    if(type_name) strcpy(sym_table[sym_count].type_name, type_name);
    current_local_offset += (step * d1 * d2); sym_table[sym_count].offset = current_local_offset; sym_count++;
}
Symbol* find_symbol(const char *name) {
    for (int i = sym_count - 1; i >= 0; i--) if (strcmp(sym_table[i].name, name) == 0) return &sym_table[i];
    return NULL;
}

void tokenize(FILE *file, Token tokens[], int *token_count) {
    int ch; *token_count = 0;
    while ((ch = fgetc(file)) != EOF) {
        if (isspace(ch)) continue;
        if (ch == '/') {
            int next = fgetc(file);
            if (next == '/') { while ((ch = fgetc(file)) != EOF && ch != '\n'); continue; } 
            else if (next == '*') { while ((ch = fgetc(file)) != EOF) { if (ch == '*') { if ((ch = fgetc(file)) == '/') break; ungetc(ch, file); } } continue; } 
            else { ungetc(next, file); tokens[*token_count].type = TOKEN_DIV; strcpy(tokens[*token_count].value, "/"); (*token_count)++; continue; }
        }
        else if (ch == '"') {
            int i = 0; while ((ch = fgetc(file)) != EOF && ch != '"') tokens[*token_count].value[i++] = ch;
            tokens[*token_count].value[i] = '\0'; tokens[*token_count].type = TOKEN_STRING; 
            tokens[*token_count].str_id = global_str_counter++; (*token_count)++;
        } 
        else if (isdigit(ch)) {
            int i = 0; tokens[*token_count].value[i++] = ch;
            while ((ch = fgetc(file)) != EOF && (isdigit(ch) || ch == 'x' || ch == 'X' || (ch >= 'A' && ch <= 'F') || (ch >= 'a' && ch <= 'f'))) tokens[*token_count].value[i++] = ch;
            if (ch != EOF) ungetc(ch, file); tokens[*token_count].value[i] = '\0'; tokens[*token_count].type = TOKEN_NUMBER; (*token_count)++;
        }
        else if (ch == '=') { int next = fgetc(file); if (next == '=') { tokens[*token_count].type = TOKEN_EQEQ; strcpy(tokens[*token_count].value, "=="); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_EQ; strcpy(tokens[*token_count].value, "="); } (*token_count)++; }
        else if (ch == '!') { int next = fgetc(file); if (next == '=') { tokens[*token_count].type = TOKEN_NEQ; strcpy(tokens[*token_count].value, "!="); (*token_count)++; } else exit(1); }
        else if (ch == '<') { int next = fgetc(file); if (next == '<') { tokens[*token_count].type = TOKEN_SHL; strcpy(tokens[*token_count].value, "<<"); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_LESS; strcpy(tokens[*token_count].value, "<"); } (*token_count)++; }
        else if (ch == '>') { int next = fgetc(file); if (next == '>') { tokens[*token_count].type = TOKEN_SHR; strcpy(tokens[*token_count].value, ">>"); } else { ungetc(next, file); tokens[*token_count].type = TOKEN_GREATER; strcpy(tokens[*token_count].value, ">"); } (*token_count)++; }
        else if (ch == '&') { tokens[*token_count].type = TOKEN_AMPER; strcpy(tokens[*token_count].value, "&"); (*token_count)++; }
        else if (ch == '|') { tokens[*token_count].type = TOKEN_OR; strcpy(tokens[*token_count].value, "|"); (*token_count)++; }
        else if (ch == '^') { tokens[*token_count].type = TOKEN_XOR; strcpy(tokens[*token_count].value, "^"); (*token_count)++; }
        else if (ch == ':') { tokens[*token_count].type = TOKEN_COLON; strcpy(tokens[*token_count].value, ":"); (*token_count)++; }
        else if (ch == '{') { tokens[*token_count].type = TOKEN_LBRACE; strcpy(tokens[*token_count].value, "{"); (*token_count)++; }
        else if (ch == '}') { tokens[*token_count].type = TOKEN_RBRACE; strcpy(tokens[*token_count].value, "}"); (*token_count)++; }
        else if (ch == '[') { tokens[*token_count].type = TOKEN_LBRACKET; strcpy(tokens[*token_count].value, "["); (*token_count)++; }
        else if (ch == ']') { tokens[*token_count].type = TOKEN_RBRACKET; strcpy(tokens[*token_count].value, "]"); (*token_count)++; }
        else if (ch == '(') { tokens[*token_count].type = TOKEN_LPAREN; strcpy(tokens[*token_count].value, "("); (*token_count)++; } 
        else if (ch == ')') { tokens[*token_count].type = TOKEN_RPAREN; strcpy(tokens[*token_count].value, ")"); (*token_count)++; }
        else if (ch == '+') { tokens[*token_count].type = TOKEN_PLUS; strcpy(tokens[*token_count].value, "+"); (*token_count)++; }
        else if (ch == '-') { tokens[*token_count].type = TOKEN_MINUS; strcpy(tokens[*token_count].value, "-"); (*token_count)++; }
        else if (ch == '*') { tokens[*token_count].type = TOKEN_MUL; strcpy(tokens[*token_count].value, "*"); (*token_count)++; }
        else if (ch == '.') { tokens[*token_count].type = TOKEN_DOT; strcpy(tokens[*token_count].value, "."); (*token_count)++; }
        else if (ch == ',') { tokens[*token_count].type = TOKEN_COMMA; strcpy(tokens[*token_count].value, ","); (*token_count)++; }
        else if (isalpha(ch) || (unsigned char)ch >= 0x80) {
            int i = 0; tokens[*token_count].value[i++] = ch;
            while ((ch = fgetc(file)) != EOF && (isalnum(ch) || ch == '_' || (unsigned char)ch >= 0x80)) tokens[*token_count].value[i++] = ch;
            if (ch != EOF) ungetc(ch, file); tokens[*token_count].value[i] = '\0';

            if (strcmp(tokens[*token_count].value, "Vypiš") == 0) tokens[*token_count].type = TOKEN_VYPIS;
            else if (strcmp(tokens[*token_count].value, "VypisHodnotu") == 0) tokens[*token_count].type = TOKEN_VYPIS_HODNOTU;
            else if (strcmp(tokens[*token_count].value, "CtiHodnotu") == 0) tokens[*token_count].type = TOKEN_CTI_HODNOTU;
            else if (strcmp(tokens[*token_count].value, "Opakuj") == 0) tokens[*token_count].type = TOKEN_OPAKUJ;
            else if (strcmp(tokens[*token_count].value, "Dokud") == 0) tokens[*token_count].type = TOKEN_DOKUD;
            else if (strcmp(tokens[*token_count].value, "Struktura") == 0) tokens[*token_count].type = TOKEN_STRUKTURA;
            else if (strcmp(tokens[*token_count].value, "Instance") == 0) tokens[*token_count].type = TOKEN_INSTANCE;
            else if (strcmp(tokens[*token_count].value, "Ukonci") == 0) tokens[*token_count].type = TOKEN_UKONCI;
            else if (strcmp(tokens[*token_count].value, "Pokracuj") == 0) tokens[*token_count].type = TOKEN_POKRACUJ;
            else if (strcmp(tokens[*token_count].value, "Metoda") == 0) tokens[*token_count].type = TOKEN_METODA;
            else if (strcmp(tokens[*token_count].value, "Volej") == 0) tokens[*token_count].type = TOKEN_VOLEJ;
            else if (strcmp(tokens[*token_count].value, "Vrat") == 0) tokens[*token_count].type = TOKEN_VRAT;
            else if (strcmp(tokens[*token_count].value, "Globalni") == 0) tokens[*token_count].type = TOKEN_GLOBALNI;
            else if (strcmp(tokens[*token_count].value, "Lokalni") == 0) tokens[*token_count].type = TOKEN_LOKALNI;
            else if (strcmp(tokens[*token_count].value, "LokalniPole") == 0) tokens[*token_count].type = TOKEN_LOKALNI_POLE;
            else if (strcmp(tokens[*token_count].value, "Pokud") == 0) tokens[*token_count].type = TOKEN_POKUD;
            else if (strcmp(tokens[*token_count].value, "Jinak") == 0) tokens[*token_count].type = TOKEN_JINAK;
            else if (strcmp(tokens[*token_count].value, "Asm") == 0) tokens[*token_count].type = TOKEN_ASM;
            else if (strcmp(tokens[*token_count].value, "ZapisNaAdresu") == 0) tokens[*token_count].type = TOKEN_ZAPIS_ADRESU;
            else if (strcmp(tokens[*token_count].value, "CtiZAdresu") == 0) tokens[*token_count].type = TOKEN_CTI_ADRESU;
            else if (strcmp(tokens[*token_count].value, "OtevriSoubor") == 0) tokens[*token_count].type = TOKEN_OTEVRI_SOUBOR;
            else if (strcmp(tokens[*token_count].value, "ZavriSoubor") == 0) tokens[*token_count].type = TOKEN_ZAVRI_SOUBOR;
            else if (strcmp(tokens[*token_count].value, "CtiZnak") == 0) tokens[*token_count].type = TOKEN_CTI_ZNAK;
            else if (strcmp(tokens[*token_count].value, "ZapisZnak") == 0) tokens[*token_count].type = TOKEN_ZAPIS_ZNAK;
            else if (strcmp(tokens[*token_count].value, "CtiByte") == 0) tokens[*token_count].type = TOKEN_CTI_BYTE;
            else if (strcmp(tokens[*token_count].value, "ZapisByte") == 0) tokens[*token_count].type = TOKEN_ZAPIS_BYTE;
            else tokens[*token_count].type = TOKEN_IDENTIFIER;
            
            (*token_count)++;
        } else { printf("Chyba lexeru: %c\n", ch); exit(1); }
    }
    tokens[*token_count].type = TOKEN_EOF;
}

typedef enum {
    AST_PROGRAM, AST_BLOCK, AST_METHOD, AST_VAR_DECL, AST_ASSIGN, 
    AST_EXPR, AST_IF, AST_WHILE, AST_LOOP, AST_SYSCALL, AST_ASM_NODE,
    AST_MEM_WRITE, AST_MEM_READ, AST_ARRAY_READ, AST_ARRAY_ASSIGN,
    AST_MEMBER_READ, AST_MEMBER_ASSIGN, AST_CALL, AST_RETURN, AST_BREAK, AST_CONTINUE, AST_NOP
} AST_NodeType;

typedef struct AST_Node {
    AST_NodeType type;
    struct AST_Node *left;   
    struct AST_Node *right;  
    struct AST_Node *idx1;   
    struct AST_Node *idx2;   
    struct AST_Node *alt;    
    struct AST_Node **stmts; 
    int stmt_count;
    char name[MAX_TOKEN_LEN];
    char sub_name[MAX_TOKEN_LEN]; 
    int int_val;
    TokenType op; 
} AST_Node;

AST_Node* create_node(AST_NodeType type) {
    AST_Node* node = (AST_Node*)custom_calloc(1, sizeof(AST_Node));
    node->type = type; return node;
}

AST_Node* parse_expression(Token tokens[], int *idx) {
    AST_Node* expr = create_node(AST_EXPR);
    if (tokens[*idx].type == TOKEN_NUMBER) { expr->op = TOKEN_NUMBER; strcpy(expr->name, tokens[*idx].value); (*idx)++; }
    else if (tokens[*idx].type == TOKEN_STRING) {
        expr->op = TOKEN_STRING; expr->int_val = tokens[*idx].str_id; (*idx)++; 
    }
    else if (tokens[*idx].type == TOKEN_OTEVRI_SOUBOR) {
        expr->op = TOKEN_OTEVRI_SOUBOR; (*idx)++;
        expr->left = parse_expression(tokens, idx);  
        if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; 
        expr->right = parse_expression(tokens, idx); 
    }
    else if (tokens[*idx].type == TOKEN_CTI_ZNAK) {
        expr->op = TOKEN_CTI_ZNAK; (*idx)++; expr->left = parse_expression(tokens, idx);  
    }
    else if (tokens[*idx].type == TOKEN_CTI_BYTE) {
        expr->type = AST_MEM_READ; expr->op = TOKEN_CTI_BYTE; (*idx)++; expr->left = parse_expression(tokens, idx);  
    }
    else if (tokens[*idx].type == TOKEN_IDENTIFIER) {
        if (tokens[*idx+1].type == TOKEN_LPAREN) {
            expr->type = AST_CALL; strcpy(expr->name, tokens[*idx].value); *idx += 2;
            expr->stmts = custom_malloc(20 * sizeof(AST_Node*)); expr->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) {
                expr->stmts[expr->stmt_count++] = parse_expression(tokens, idx);
                if (tokens[*idx].type == TOKEN_COMMA) (*idx)++;
            }
            (*idx)++;
        } 
        else if (tokens[*idx+1].type == TOKEN_DOT) {
            expr->type = AST_MEMBER_READ; strcpy(expr->name, tokens[*idx].value); strcpy(expr->sub_name, tokens[*idx+2].value); *idx += 3;
        } else if (tokens[*idx+1].type == TOKEN_LBRACKET) {
            expr->type = AST_ARRAY_READ; strcpy(expr->name, tokens[*idx].value); *idx += 2;
            expr->idx1 = parse_expression(tokens, idx); (*idx)++; 
            if (tokens[*idx].type == TOKEN_LBRACKET) { (*idx)++; expr->idx2 = parse_expression(tokens, idx); (*idx)++; }
        } else {
            expr->op = TOKEN_IDENTIFIER; strcpy(expr->name, tokens[*idx].value); (*idx)++;
        }
    }
    else if (tokens[*idx].type == TOKEN_AMPER) { (*idx)++; expr->op = TOKEN_AMPER; strcpy(expr->name, tokens[*idx].value); (*idx)++; }
    
    if (tokens[*idx].type == TOKEN_PLUS || tokens[*idx].type == TOKEN_MINUS || tokens[*idx].type == TOKEN_MUL || tokens[*idx].type == TOKEN_DIV ||
        tokens[*idx].type == TOKEN_EQEQ || tokens[*idx].type == TOKEN_NEQ || tokens[*idx].type == TOKEN_LESS || tokens[*idx].type == TOKEN_GREATER ||
        tokens[*idx].type == TOKEN_AND || tokens[*idx].type == TOKEN_OR || tokens[*idx].type == TOKEN_XOR || tokens[*idx].type == TOKEN_SHL || tokens[*idx].type == TOKEN_SHR) {
        
        AST_Node* binop = create_node(AST_EXPR); binop->op = tokens[*idx].type; binop->left = expr; (*idx)++;
        binop->right = parse_expression(tokens, idx);
        return binop;
    }
    return expr;
}

AST_Node* parse_block(Token tokens[], int *idx);

AST_Node* parse_statement(Token tokens[], int *idx, int step) {
    int i = *idx; AST_Node* stmt = NULL;

    if (tokens[i].type == TOKEN_LOKALNI) {
        stmt = create_node(AST_VAR_DECL); strcpy(stmt->name, tokens[i+1].value); *idx = i + 3;
        stmt->right = parse_expression(tokens, idx);
        add_local_symbol(stmt->name, step, 1, 1, NULL);
    }
    else if (tokens[i].type == TOKEN_LOKALNI_POLE) {
        char *name = tokens[i+1].value; *idx = i + 3;
        int d1 = atoi(tokens[*idx].value); *idx += 2;
        int d2 = 1;
        if (tokens[*idx].type == TOKEN_LBRACKET) { (*idx)++; d2 = atoi(tokens[*idx].value); *idx += 2; }
        add_local_symbol(name, step, d1, d2, NULL);
        return create_node(AST_NOP);
    }
    else if (tokens[i].type == TOKEN_INSTANCE) {
        char *type_name = tokens[i+1].value; char *inst_name = tokens[i+2].value; *idx = i + 3;
        add_local_symbol(inst_name, step, get_struct_size(type_name), 1, type_name);
        return create_node(AST_NOP);
    }
    else if (tokens[i].type == TOKEN_IDENTIFIER) {
        if (tokens[i+1].type == TOKEN_LPAREN) { 
            stmt = create_node(AST_CALL); strcpy(stmt->name, tokens[i].value); *idx = i + 2;
            stmt->stmts = custom_malloc(20 * sizeof(AST_Node*)); stmt->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) {
                stmt->stmts[stmt->stmt_count++] = parse_expression(tokens, idx);
                if (tokens[*idx].type == TOKEN_COMMA) (*idx)++;
            }
            (*idx)++; 
        }
        else if (tokens[i+1].type == TOKEN_EQ) {
            stmt = create_node(AST_ASSIGN); strcpy(stmt->name, tokens[i].value); *idx = i + 2;
            stmt->right = parse_expression(tokens, idx);
        } else if (tokens[i+1].type == TOKEN_DOT) {
            stmt = create_node(AST_MEMBER_ASSIGN); strcpy(stmt->name, tokens[i].value); strcpy(stmt->sub_name, tokens[i+2].value); *idx = i + 4;
            stmt->right = parse_expression(tokens, idx);
        } else if (tokens[i+1].type == TOKEN_LBRACKET) {
            stmt = create_node(AST_ARRAY_ASSIGN); strcpy(stmt->name, tokens[i].value); *idx = i + 2;
            stmt->idx1 = parse_expression(tokens, idx); *idx += 1;
            if (tokens[*idx].type == TOKEN_LBRACKET) { *idx += 1; stmt->idx2 = parse_expression(tokens, idx); *idx += 1; }
            *idx += 1; stmt->right = parse_expression(tokens, idx);
        } else { *idx = i + 1; }
    }
    else if (tokens[i].type == TOKEN_POKUD) {
        stmt = create_node(AST_IF); *idx = i + 1; stmt->left = parse_expression(tokens, idx); *idx += 1;
        stmt->right = parse_block(tokens, idx);
        if (tokens[*idx].type == TOKEN_JINAK) { *idx += 2; stmt->alt = parse_block(tokens, idx); }
    }
    else if (tokens[i].type == TOKEN_DOKUD) {
        stmt = create_node(AST_WHILE); *idx = i + 1; stmt->left = parse_expression(tokens, idx); *idx += 1;
        stmt->right = parse_block(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_ZAPIS_ADRESU) {
        stmt = create_node(AST_MEM_WRITE); *idx = i + 1; 
        stmt->left = parse_expression(tokens, idx); 
        if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; 
        stmt->right = parse_expression(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_ZAPIS_BYTE) {
        stmt = create_node(AST_MEM_WRITE); stmt->op = TOKEN_ZAPIS_BYTE; *idx = i + 1;
        stmt->left = parse_expression(tokens, idx);  
        if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; 
        stmt->right = parse_expression(tokens, idx); 
    }
    else if (tokens[i].type == TOKEN_ZAVRI_SOUBOR) {
        stmt = create_node(AST_SYSCALL); stmt->op = TOKEN_ZAVRI_SOUBOR; *idx = i + 1;
        stmt->left = parse_expression(tokens, idx);  
    }
    else if (tokens[i].type == TOKEN_ZAPIS_ZNAK) {
        stmt = create_node(AST_SYSCALL); stmt->op = TOKEN_ZAPIS_ZNAK; *idx = i + 1;
        stmt->left = parse_expression(tokens, idx);  
        if (tokens[*idx].type == TOKEN_COMMA) (*idx)++; 
        stmt->right = parse_expression(tokens, idx); 
    }
    else if (tokens[i].type == TOKEN_VYPIS) {
        stmt = create_node(AST_SYSCALL); stmt->op = TOKEN_VYPIS; stmt->int_val = tokens[i+1].str_id; *idx = i + 2;
    }
    else if (tokens[i].type == TOKEN_VYPIS_HODNOTU) {
        stmt = create_node(AST_SYSCALL); stmt->op = TOKEN_VYPIS_HODNOTU; *idx = i + 1; stmt->left = parse_expression(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_CTI_HODNOTU) {
        stmt = create_node(AST_SYSCALL); stmt->op = TOKEN_CTI_HODNOTU; *idx = i + 1; stmt->left = parse_expression(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_OPAKUJ) {
        stmt = create_node(AST_LOOP); *idx = i + 1; stmt->left = parse_expression(tokens, idx); *idx += 1;
        current_local_offset += step;
        stmt->int_val = current_local_offset;
        stmt->right = parse_block(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_ASM) {
        stmt = create_node(AST_ASM_NODE); strcpy(stmt->name, tokens[i+1].value); *idx = i + 2;
    }
    else if (tokens[i].type == TOKEN_VOLEJ) { 
        stmt = create_node(AST_CALL); strcpy(stmt->name, tokens[i+1].value); *idx = i + 2;
        if (tokens[*idx].type == TOKEN_LPAREN) {
            (*idx)++; stmt->stmts = custom_malloc(20 * sizeof(AST_Node*)); stmt->stmt_count = 0;
            while (tokens[*idx].type != TOKEN_RPAREN && tokens[*idx].type != TOKEN_EOF) {
                stmt->stmts[stmt->stmt_count++] = parse_expression(tokens, idx);
                if (tokens[*idx].type == TOKEN_COMMA) (*idx)++;
            }
            (*idx)++;
        }
    }
    else if (tokens[i].type == TOKEN_VRAT) {
        stmt = create_node(AST_RETURN); *idx = i + 1;
        if (tokens[*idx].type != TOKEN_RBRACE) stmt->left = parse_expression(tokens, idx);
    }
    else if (tokens[i].type == TOKEN_UKONCI) { stmt = create_node(AST_BREAK); *idx = i + 1; }
    else if (tokens[i].type == TOKEN_POKRACUJ) { stmt = create_node(AST_CONTINUE); *idx = i + 1; }
    else { *idx = i + 1; } 

    return stmt ? stmt : create_node(AST_NOP);
}

AST_Node* parse_block(Token tokens[], int *idx) {
    AST_Node* block = create_node(AST_BLOCK); block->stmts = custom_malloc(200 * sizeof(AST_Node*)); block->stmt_count = 0;
    while (tokens[*idx].type != TOKEN_RBRACE && tokens[*idx].type != TOKEN_EOF) {
        AST_Node* stmt = parse_statement(tokens, idx, 8); 
        if (stmt && stmt->type != AST_NOP) block->stmts[block->stmt_count++] = stmt;
    } (*idx)++; return block;
}

AST_Node* parse_program(Token tokens[], int token_count, int target_os) {
    AST_Node* root = create_node(AST_PROGRAM); root->stmts = custom_malloc(1000 * sizeof(AST_Node*)); root->stmt_count = 0;
    int idx = 0; int step = (target_os == OS_KERNEL) ? 4 : 8;

    while (idx < token_count && tokens[idx].type != TOKEN_EOF) {
        if (tokens[idx].type == TOKEN_STRUKTURA) {
            idx++; strcpy(struct_registry[struct_count].name, tokens[idx++].value); idx++;
            struct_registry[struct_count].count = 0;
            while (tokens[idx].type == TOKEN_IDENTIFIER) { strcpy(struct_registry[struct_count].members[struct_registry[struct_count].count++], tokens[idx++].value); }
            idx++; struct_count++;
        }
        else if (tokens[idx].type == TOKEN_GLOBALNI) { idx += 4; }
        else if (tokens[idx].type == TOKEN_METODA) {
            AST_Node* method = create_node(AST_METHOD); strcpy(method->name, tokens[idx+1].value); idx += 2;
            
            current_local_offset = 0;
            
            if (tokens[idx].type == TOKEN_LPAREN) {
                idx++; int arg_idx = 0;
                while (tokens[idx].type != TOKEN_RPAREN && tokens[idx].type != TOKEN_EOF) {
                    if (tokens[idx].type == TOKEN_IDENTIFIER) {
                        strcpy(sym_table[sym_count].name, tokens[idx].value);
                        sym_table[sym_count].is_global = 0;
                        sym_table[sym_count].offset = -((arg_idx + 2) * step); 
                        sym_count++; arg_idx++; idx++;
                        if (tokens[idx].type == TOKEN_COMMA) idx++;
                    }
                }
                idx++; 
            }
            method->right = parse_block(tokens, &idx); root->stmts[root->stmt_count++] = method;
        } else {
            AST_Node* stmt = parse_statement(tokens, &idx, step);
            if (stmt && stmt->type != AST_NOP) root->stmts[root->stmt_count++] = stmt;
        }
    }
    return root;
}

int label_counter = 0;

void generate_expr(FILE *out, AST_Node *expr, int is_k, const char *ax, const char *bx, const char *bp, int step) {
    if (expr->op == TOKEN_NUMBER) { fprintf(out, "    mov %s, %s\n", ax, expr->name); }
    else if (expr->op == TOKEN_STRING) { 
        fprintf(out, "    lea %s, [%s str%d]\n", ax, is_k ? "" : "rel", expr->int_val); 
    }
    else if (expr->op == TOKEN_IDENTIFIER) {
        Symbol *s = find_symbol(expr->name);
        if (s->is_global) fprintf(out, "    mov %s, [%s gvar_%s]\n", ax, is_k ? "" : "rel", s->name);
        else fprintf(out, "    mov %s, [%s %s %d]\n", ax, bp, O_SIGN(s->offset), O_ABS(s->offset));
    }
    else if (expr->type == AST_MEMBER_READ) {
        Symbol *s = find_symbol(expr->name);
        int real_offset = s->offset - get_member_offset(s->type_name, expr->sub_name, step);
        fprintf(out, "    mov %s, [%s %s %d]\n", ax, bp, O_SIGN(real_offset), O_ABS(real_offset));
    }
    else if (expr->type == AST_ARRAY_READ) {
        Symbol *s = find_symbol(expr->name);
        generate_expr(out, expr->idx1, is_k, ax, bx, bp, step);
        if (expr->idx2) { 
            fprintf(out, "    imul %s, %s, %d\n", bx, ax, s->dim2); 
            fprintf(out, "    push %s\n", is_k?"ebx":"rbx");
            generate_expr(out, expr->idx2, is_k, ax, bx, bp, step);
            fprintf(out, "    pop %s\n", is_k?"ebx":"rbx");
            fprintf(out, "    add %s, %s\n", ax, bx); 
        }
        fprintf(out, "    imul %s, %s, %d\n", ax, ax, step);
        fprintf(out, "    mov %s, %s\n    %s %s, %d\n    add %s, %s\n", bx, bp, s->offset < 0 ? "add" : "sub", bx, O_ABS(s->offset), bx, ax);
        fprintf(out, "    mov %s, [%s]\n", ax, bx);
    }
    else if (expr->type == AST_MEM_READ && expr->op == TOKEN_CTI_BYTE) {
        generate_expr(out, expr->left, is_k, ax, bx, bp, step);
        fprintf(out, "    xor %s, %s\n", bx, bx); 
        fprintf(out, "    mov bl, byte [%s]\n", ax);
        fprintf(out, "    mov %s, %s\n", ax, bx);
    }
    else if (expr->op == TOKEN_OTEVRI_SOUBOR) {
        generate_expr(out, expr->right, is_k, ax, bx, bp, step); 
        fprintf(out, "    push %s\n", is_k ? "eax" : "rax");
        generate_expr(out, expr->left, is_k, ax, bx, bp, step);  
        fprintf(out, "    pop %s\n", is_k ? "ebx" : "rbx");
        if (!is_k) {
            #if OS_WINDOWS
                fprintf(out, "    mov rcx, rax\n    mov rdx, rbx\n");
            #else
                fprintf(out, "    mov rdi, rax\n    mov rsi, rbx\n");
            #endif
            fprintf(out, "    call fopen\n");
        }
    }
    else if (expr->op == TOKEN_CTI_ZNAK) {
        generate_expr(out, expr->left, is_k, ax, bx, bp, step);
        if (!is_k) {
            #if OS_WINDOWS
                fprintf(out, "    mov rcx, rax\n");
            #else
                fprintf(out, "    mov rdi, rax\n");
            #endif
            fprintf(out, "    call fgetc\n");
        }
    }
    else if (expr->op == TOKEN_AMPER) {
        Symbol *s = find_symbol(expr->name);
        if (s->is_global) fprintf(out, "    lea %s, [%s gvar_%s]\n", ax, is_k ? "" : "rel", s->name);
        else fprintf(out, "    lea %s, [%s %s %d]\n", ax, bp, O_SIGN(s->offset), O_ABS(s->offset));
    }
    else if (expr->type == AST_CALL) { 
        for (int j = expr->stmt_count - 1; j >= 0; j--) {
            generate_expr(out, expr->stmts[j], is_k, ax, bx, bp, step);
            fprintf(out, "    push %s\n", is_k?"eax":"rax");
        }
        fprintf(out, "    call _fn_%s\n", expr->name);
        if (expr->stmt_count > 0) fprintf(out, "    add %s, %d\n", is_k?"esp":"rsp", expr->stmt_count * step);
    }
    else if (expr->left && expr->right) {
        generate_expr(out, expr->right, is_k, ax, bx, bp, step);
        fprintf(out, "    push %s\n", is_k?"eax":"rax");
        generate_expr(out, expr->left, is_k, ax, bx, bp, step);
        fprintf(out, "    pop %s\n", bx); 

        if (expr->op == TOKEN_PLUS) fprintf(out, "    add %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_MINUS) fprintf(out, "    sub %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_MUL) fprintf(out, "    imul %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_AND) fprintf(out, "    and %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_OR) fprintf(out, "    or %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_XOR) fprintf(out, "    xor %s, %s\n", ax, bx);
        else if (expr->op == TOKEN_SHL) { fprintf(out, "    mov cl, bl\n    shl %s, cl\n", ax); }
        else if (expr->op == TOKEN_SHR) { fprintf(out, "    mov cl, bl\n    shr %s, cl\n", ax); }
    }
}

void generate_ast(FILE *out, AST_Node *node, int target_os, int loop_start, int loop_end) {
    if (!node) return;
    int is_k = (target_os == OS_KERNEL);
    const char *ax = is_k ? "eax" : "rax", *bx = is_k ? "ebx" : "rbx", *bp = is_k ? "ebp" : "rbp", *word = is_k ? "dword" : "qword";
    int step = is_k ? 4 : 8;

    if (node->type == AST_VAR_DECL) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step);
        Symbol *s = find_symbol(node->name);
        fprintf(out, "    mov %s [%s %s %d], %s\n", word, bp, O_SIGN(s->offset), O_ABS(s->offset), ax);
    }
    else if (node->type == AST_ASSIGN) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step);
        Symbol *s = find_symbol(node->name);
        if (s->is_global) fprintf(out, "    mov %s [%s gvar_%s], %s\n", word, is_k ? "" : "rel", s->name, ax);
        else fprintf(out, "    mov %s [%s %s %d], %s\n", word, bp, O_SIGN(s->offset), O_ABS(s->offset), ax);
    }
    else if (node->type == AST_MEMBER_ASSIGN) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step);
        Symbol *s = find_symbol(node->name);
        int real_offset = s->offset - get_member_offset(s->type_name, node->sub_name, step);
        fprintf(out, "    mov [%s %s %d], %s\n", bp, O_SIGN(real_offset), O_ABS(real_offset), ax);
    }
    else if (node->type == AST_ARRAY_ASSIGN) {
        generate_expr(out, node->idx1, is_k, ax, bx, bp, step);
        Symbol *s = find_symbol(node->name);
        if (node->idx2) {
            fprintf(out, "    imul %s, %s, %d\n", bx, ax, s->dim2);
            fprintf(out, "    push %s\n", is_k?"ebx":"rbx");
            generate_expr(out, node->idx2, is_k, ax, bx, bp, step);
            fprintf(out, "    pop %s\n", is_k?"ebx":"rbx");
            fprintf(out, "    add %s, %s\n", ax, bx);
        }
        fprintf(out, "    imul %s, %s, %d\n", ax, ax, step);
        fprintf(out, "    mov %s, %s\n    %s %s, %d\n    add %s, %s\n", bx, bp, s->offset < 0 ? "add" : "sub", bx, O_ABS(s->offset), bx, ax);
        fprintf(out, "    push %s\n", is_k?"ebx":"rbx"); 
        generate_expr(out, node->right, is_k, ax, bx, bp, step); 
        fprintf(out, "    pop %s\n", is_k?"ebx":"rbx"); 
        fprintf(out, "    mov [%s], %s\n", bx, ax);
    }
    else if (node->type == AST_MEM_WRITE) {
        generate_expr(out, node->right, is_k, ax, bx, bp, step);
        fprintf(out, "    push %s\n", is_k?"eax":"rax");
        generate_expr(out, node->left, is_k, ax, bx, bp, step); 
        fprintf(out, "    pop %s\n", is_k?"ebx":"rbx");
        if (node->op == TOKEN_ZAPIS_BYTE) {
            fprintf(out, "    mov byte [%s], bl\n", ax);
        } else {
            fprintf(out, "    mov %s [%s], %s\n", word, ax, bx);
        }
    }
    else if (node->type == AST_IF || node->type == AST_WHILE) {
        int lbl = label_counter++;
        if (node->type == AST_WHILE) fprintf(out, ".L_start_%d:\n", lbl);
        
        generate_expr(out, node->left->left, is_k, ax, bx, bp, step);
        fprintf(out, "    push %s\n", is_k?"eax":"rax");
        generate_expr(out, node->left->right, is_k, ax, bx, bp, step);
        fprintf(out, "    pop %s\n", bx);
        fprintf(out, "    cmp %s, %s\n", bx, ax);
        
        if (node->left->op == TOKEN_EQEQ) fprintf(out, "    jne .L_end_%d\n", lbl);
        else if (node->left->op == TOKEN_LESS) fprintf(out, "    jge .L_end_%d\n", lbl);
        else if (node->left->op == TOKEN_NEQ) fprintf(out, "    je .L_end_%d\n", lbl);
        else if (node->left->op == TOKEN_GREATER) fprintf(out, "    jle .L_end_%d\n", lbl);
        
        generate_ast(out, node->right, target_os, lbl, lbl); 
        
        if (node->type == AST_IF && node->alt) {
            fprintf(out, "    jmp .L_else_end_%d\n.L_end_%d:\n", lbl, lbl);
            generate_ast(out, node->alt, target_os, loop_start, loop_end);
            fprintf(out, ".L_else_end_%d:\n", lbl);
        } else {
            if (node->type == AST_WHILE) {
                fprintf(out, ".L_cont_%d:\n", lbl);
                fprintf(out, "    jmp .L_start_%d\n", lbl);
            }
            fprintf(out, ".L_end_%d:\n", lbl);
        }
    }
    else if (node->type == AST_LOOP) {
        int lbl = label_counter++;
        generate_expr(out, node->left, is_k, ax, bx, bp, step);
        
        int offset = node->int_val;
        fprintf(out, "    mov %s [%s - %d], %s\n", word, bp, offset, ax);
        fprintf(out, ".L_start_%d:\n", lbl);
        fprintf(out, "    cmp %s [%s - %d], 0\n    je .L_end_%d\n", word, bp, offset, lbl);
        
        generate_ast(out, node->right, target_os, lbl, lbl); 
        
        fprintf(out, ".L_cont_%d:\n", lbl);
        fprintf(out, "    dec %s [%s - %d]\n    jmp .L_start_%d\n.L_end_%d:\n", word, bp, offset, lbl, lbl);
    }
    else if (node->type == AST_BLOCK) { for (int i = 0; i < node->stmt_count; i++) generate_ast(out, node->stmts[i], target_os, loop_start, loop_end); }
    else if (node->type == AST_PROGRAM) { for (int i = 0; i < node->stmt_count; i++) { if (node->stmts[i]->type != AST_METHOD) generate_ast(out, node->stmts[i], target_os, -1, -1); } }
    else if (node->type == AST_SYSCALL && !is_k) {
        if (node->op == TOKEN_VYPIS) {
            if (target_os == OS_WINDOWS) fprintf(out, "    lea rcx, [rel str%d]\n", node->int_val);
            else fprintf(out, "    lea rdi, [rel str%d]\n", node->int_val);
            fprintf(out, "    xor rax, rax\n    call printf\n");
        }
        else if (node->op == TOKEN_VYPIS_HODNOTU) {
            generate_expr(out, node->left, is_k, ax, bx, bp, step);
            if (target_os == OS_WINDOWS) fprintf(out, "    lea rcx, [rel fmt_int]\n    mov rdx, rax\n");
            else fprintf(out, "    lea rdi, [rel fmt_int]\n    mov rsi, rax\n");
            fprintf(out, "    xor rax, rax\n    call printf\n");
        }
        else if (node->op == TOKEN_CTI_HODNOTU) {
            if (node->left->op == TOKEN_IDENTIFIER) {
                Symbol *s = find_symbol(node->left->name);
                if (target_os == OS_WINDOWS) {
                    fprintf(out, "    lea rcx, [rel fmt_scanf]\n");
                    if (s->is_global) fprintf(out, "    lea rdx, [rel gvar_%s]\n", s->name);
                    else fprintf(out, "    lea rdx, [%s %s %d]\n", bp, O_SIGN(s->offset), O_ABS(s->offset));
                } else {
                    fprintf(out, "    lea rdi, [rel fmt_scanf]\n");
                    if (s->is_global) fprintf(out, "    lea rsi, [rel gvar_%s]\n", s->name);
                    else fprintf(out, "    lea rsi, [%s %s %d]\n", bp, O_SIGN(s->offset), O_ABS(s->offset));
                }
                fprintf(out, "    xor rax, rax\n    call scanf\n");
            }
        }
        else if (node->op == TOKEN_ZAVRI_SOUBOR) {
            generate_expr(out, node->left, is_k, ax, bx, bp, step);
            if (target_os == OS_WINDOWS) fprintf(out, "    mov rcx, rax\n");
            else fprintf(out, "    mov rdi, rax\n");
            fprintf(out, "    call fclose\n");
        }
        else if (node->op == TOKEN_ZAPIS_ZNAK) {
            generate_expr(out, node->right, is_k, ax, bx, bp, step); 
            fprintf(out, "    push %s\n", is_k?"eax":"rax");
            generate_expr(out, node->left, is_k, ax, bx, bp, step); 
            fprintf(out, "    pop %s\n", is_k?"ebx":"rbx"); 
            if (target_os == OS_WINDOWS) {
                fprintf(out, "    mov rcx, rbx\n    mov rdx, rax\n");
            } else {
                fprintf(out, "    mov rdi, rbx\n    mov rsi, rax\n");
            }
            fprintf(out, "    call fputc\n");
        }
    }
    else if (node->type == AST_ASM_NODE) { fprintf(out, "    %s\n", node->name); }
    else if (node->type == AST_CALL) { 
        for (int j = node->stmt_count - 1; j >= 0; j--) {
            generate_expr(out, node->stmts[j], is_k, ax, bx, bp, step);
            fprintf(out, "    push %s\n", is_k?"eax":"rax");
        }
        fprintf(out, "    call _fn_%s\n", node->name);
        if (node->stmt_count > 0) fprintf(out, "    add %s, %d\n", is_k?"esp":"rsp", node->stmt_count * step);
    }
    else if (node->type == AST_RETURN) {
        if (node->left) generate_expr(out, node->left, is_k, ax, bx, bp, step);
        fprintf(out, "    mov %s, %s\n    pop %s\n    ret\n", is_k?"esp":"rsp", bp, bp);
    }
    else if (node->type == AST_BREAK) { fprintf(out, "    jmp .L_end_%d\n", loop_end); }
    else if (node->type == AST_CONTINUE) { fprintf(out, "    jmp .L_cont_%d\n", loop_start); }
}

void generate_asm_file(AST_Node* ast, Token tokens[], int token_count, const char *out_filename, int target_os) {
    FILE *out = fopen(out_filename, "w"); int is_k = (target_os == OS_KERNEL);

    if (is_k) fprintf(out, "section .multiboot\nalign 4\n    dd 0x1BADB002\n    dd 0x00\n    dd -(0x1BADB002)\n\n");
    fprintf(out, "section .data\n");
    if (!is_k) fprintf(out, "    fmt_int db \"%%d\", 10, 0\n    fmt_scanf db \"%%d\", 0\n"); 
    
    for (int i = 0; i < token_count; i++) {
        if (tokens[i].type == TOKEN_STRING) fprintf(out, "    str%d db \"%s\", 0\n", tokens[i].str_id, tokens[i].value);
        else if (tokens[i].type == TOKEN_GLOBALNI) {
            if (i + 3 < token_count && tokens[i+2].type == TOKEN_EQ) {
                fprintf(out, "    gvar_%s %s %s\n", tokens[i+1].value, is_k?"dd":"dq", tokens[i+3].value); add_global_symbol(tokens[i+1].value);
            }
        }
    }

    if (is_k) fprintf(out, "\nsection .bss\nalign 16\nstack_bottom:\n    resb 16384\nstack_top:\n");
    fprintf(out, "\nsection .text\n");

    if (is_k) {
        fprintf(out, "    global _start\n\n_start:\n    mov esp, stack_top\n    push ebp\n    mov ebp, esp\n    sub esp, 8192\n");
    } else {
        fprintf(out, "    global main\n    extern printf\n    extern scanf\n    extern exit\n");
        fprintf(out, "    extern fopen\n    extern fclose\n    extern fgetc\n    extern fputc\n\nmain:\n    push rbp\n    mov rbp, rsp\n    sub rsp, 8192\n");
    }
    
    current_local_offset = 0;
    generate_ast(out, ast, target_os, -1, -1); 

    if (is_k) {
        fprintf(out, "\n    cli\n.hang:\n    hlt\n    jmp .hang\n\n");
    } else {
        fprintf(out, "\n    xor rax, rax\n    mov rsp, rbp\n    pop rbp\n    %s\n", target_os == OS_WINDOWS ? "xor rcx, rcx\n    call exit" : "mov rdi, 0\n    call exit");
    }
    
    for (int i = 0; i < ast->stmt_count; i++) {
        if (ast->stmts[i]->type == AST_METHOD) {
            fprintf(out, "_fn_%s:\n    push %s\n    mov %s, %s\n    sub %s, 8192\n", ast->stmts[i]->name, is_k?"ebp":"rbp", is_k?"ebp":"rbp", is_k?"esp":"rsp", is_k?"esp":"rsp");
            generate_ast(out, ast->stmts[i]->right, target_os, -1, -1);
            fprintf(out, "    mov %s, %s\n    pop %s\n    ret\n\n", is_k?"esp":"rsp", is_k?"ebp":"rbp", is_k?"ebp":"rbp");
        }
    }
    
    fclose(out);
}

void compile_executable(const char *asm_file, int target_os, const char *output_file) {
    char cmd[512]; printf("Generuji '%s'...\n", output_file);
    if (target_os == OS_KERNEL) {
        sprintf(cmd, "nasm -f elf32 %s -o docasny.o", asm_file); system(cmd);
        sprintf(cmd, "ld -m elf_i386 -Ttext 0x100000 docasny.o -o %s.bin", output_file); system(cmd);
        system("rm docasny.o"); printf("OS vytvoren: qemu-system-i386 -kernel %s.bin\n", output_file);
    } 
    else if (target_os == OS_WINDOWS) {
        sprintf(cmd, "nasm -f win64 %s -o docasny.obj", asm_file); system(cmd);
        sprintf(cmd, "gcc docasny.obj -o %s.exe", output_file); system(cmd);
        system("del docasny.obj"); printf("Hotovo: %s\n", output_file);
    } else {
        sprintf(cmd, "nasm -f elf64 %s -o docasny.o", asm_file); system(cmd);
        sprintf(cmd, "gcc docasny.o -no-pie -o %s", output_file); system(cmd);
        system("rm docasny.o"); printf("Hotovo: %s\n", output_file);
    }
}

int main(int argc, char *argv[]) {
    int target_os = OS_WINDOWS; char *input_file = "ahoj.txt"; char *output_file = "program"; int pos_args = 0;
    for (int i = 1; i < argc; i++) {
        if (strncmp(argv[i], "--", 2) == 0) { if (strcmp(argv[i], "--kernel") == 0) target_os = OS_KERNEL; else if (strcmp(argv[i], "--linux") == 0) target_os = OS_LINUX; } 
        else { if (pos_args == 0) input_file = argv[i]; else if (pos_args == 1) output_file = argv[i]; pos_args++; }
    }
    FILE *f = fopen(input_file, "r"); if (!f) { printf("Chyba: Soubor '%s' neexistuje!\n", input_file); return 1; }
    Token tokens[MAX_TOKENS]; int token_count = 0; tokenize(f, tokens, &token_count); fclose(f);
    AST_Node* ast = parse_program(tokens, token_count, target_os);
    char asm_name[256]; sprintf(asm_name, "%s.asm", output_file);
    generate_asm_file(ast, tokens, token_count, asm_name, target_os); compile_executable(asm_name, target_os, output_file);
    return 0;
}