#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

#define MAX_WORDS 100    
#define MAX_WORD_LEN 256 
int main() {
    FILE *file = fopen("ahoj.txt", "r");
    if (file == NULL) {
        perror("Chyba při otevírání souboru");
        return 1;
    }

    char words[MAX_WORDS][MAX_WORD_LEN];
    int word_count = 0; 

    char buffer[MAX_WORD_LEN]; 
    int i = 0;
    int ch;

    while ((ch = fgetc(file)) != EOF) {
        if (ch == ' ') {
            if (i > 0) { 
                buffer[i] = '\0'; 
                
                if (word_count < MAX_WORDS) {
                    strcpy(words[word_count], buffer);
                    word_count++;
                } else {
                    printf("Varování: Dosažen maximální počet slov (%d).\n", MAX_WORDS);
                }
                i = 0; 
            }
        } else {
            if (i < MAX_WORD_LEN - 1) {
                buffer[i++] = (char)ch;
            }
        }
    }

    fclose(file);

for (size_t i = 0; i < word_count; i++) 
{

    if (strcmp(words[i], "Vypiš") == 0) {
        if (i + 1 < word_count) {
            
            char *next_word = words[i + 1]; 
            
            if (next_word[0] == '"') {
                
                for (size_t j = 0; j < strlen(next_word); j++) 
                {
                   
                    if (next_word[j] != '"') {
                        printf("%c", next_word[j]);
                    }
                }
                printf("\n");
            }
        }
    }
 
}
    return 0;
}