#include <stdio.h>

#define MAX_WORD_SIZE 20

void readstring(char str[]);
void printsort(char word[], int word_size);
int getStringLen(char word[]);

int main(void) {
  char word[MAX_WORD_SIZE];
  while (1) {
    printf("Enter word: ");
    readstring(word);
    if (word[0] == '\n') {
      break;
    }
    printf("Original word: %s\n", word);
    printf("Alphabetized word ");
    printsort(word, getStringLen(word));
    printf("\n");
  }

  printf("Exiting");
  return 0;
}

void readstring(char str[]) {
  int ch;
  int i = 0;
  while ((ch = getchar()) != '\n') {
    str[i++] = (char)ch;
  }
  str[i] = '\0';
}

void printsort(char word[], int word_size) {
  int i, j, k, smallCount;
  int smallest = 9999;
  int minCeiling = -1;

  for (i = 0; i < word_size; i++) {
    smallest = 9999;
    smallCount = 0;
    for (j = 0; j < word_size; j++) {
      if (minCeiling < word[j] && word[j] < smallest) {
        smallest = word[j];
        smallCount = 1;
      } else if (smallest == word[j]) {
        smallCount++;
      }
    }
    for (k = 0; k < smallCount; k++) {
      printf("%c", smallest);
    }
    minCeiling = smallest;
  }
}

int getStringLen(char word[]) {
  int i = 0;
  while (word[i] != '\0') {
    i++;
  }
  return i;
}