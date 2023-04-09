#include <math.h>
#include <stdio.h>
#include <string.h>

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
  int i = 0;
  int count = 0;
  while (pow(2, i) < num) {
    i++;
  }
  while (num > 0) {
    printf("%d\n", num);
    printf("%f\n", pow(2, i));
    if (pow(2, i) <= num) {
      printf("i: %d\n", i);
      num -= pow(2, i);
      count++;
    }
    i--;
  }
  return count;
}