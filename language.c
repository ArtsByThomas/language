#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

#define MAX_WORDS 100    
#define MAX_WORD_LEN 256 
int main() {
    FILE *file = fopen("soubor.txt", "r");
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
        if (ch == ' ' || ch == '\n' || ch == '\t' || ch == '\r') {
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

    printf("\n--- Všechna načtená slova v poli (%d slov) ---\n", word_count);
    for (int j = 0; j < word_count; j++) {
        printf("Slovo na indexu %d: %s\n", j, words[j]);
    }

    return 0;
}