#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT_SIZE sizeof(int) * 8

int countBits(int num);

/* This is a comment */
int main(void) {
  int num;
  char prompt[] = "";
  printf("Welcome to the CountOnes program.\n");

  while (!(strcmp(prompt, "n")) == 0) {
    printf("\nPlease enter a number: ");
    scanf("%d", &num);
    printf("The number of bits set is: %d\n", countBits(num));
    printf("Continue (y/n)?: ");
    scanf("%s", prompt);
  }
  printf("Exiting");
  return 0;
}

int countBits(int num) {
  int count = 0;
  while (num != 0) { 
    printf("%d %d\n", num, count);
    count += num & 1;
    num >>=  1;
  }
  return count;
}