#include <stdio.h>

#define MAX_WORD_SIZE 20



int countBits(int num);
char *getWord(char *word);
void printsort(char word[]);

int main(void) {
  char word[MAX_WORD_SIZE];

  while (1) {
    printf("Enter word: ");
    getWord(word);

    if (&word == '\n') {
      break;
    }
    printsort(word);
  }

  printf("Exiting");
  return 0;
}
// for (int i = 0; i < word.length; i++) {
    //   for (int j = i + 1; j < word.length; j++) {
    //     if (word[i] > word[j]) {
    //       char temp = word[i];
    //       word[i] = word[j];
    //       word[j] = temp;
    //     }
    //   }
    //   printf("%c", word[i]);
    // }
    // printf("\n");
char *getWord(char *word) {
  printf("Enter word: ");
  int i = 0;
  char ch = getchar();
  while (ch != '\n' && ch != ' ') {
    word[i] = ch;
    ch = getchar();
    i++;
  }
  while (ch != '\n') {
    ch = getchar();
    word += ch;
  }
  word[i] = '\0';
  return word;
}

void printsort(char word[]) {
  printf("Original word: %s\n", word);
  printf("Alphabetized word: ");
  for (int i = 0; i < word.length; i++) {
    for (int j = i + 1; j < word.length; j++) {
      if (word[i] > word[j]) {
        char temp = word[i];
        word[i] = word[j];
        word[j] = temp;
      }
    }
    printf("%c", word[i]);
  }
  printf("\n");
}