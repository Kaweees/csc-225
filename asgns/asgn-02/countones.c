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
  int count = 0;
  unsigned int cast = (unsigned int)num; /*cast to unsigned int*/
  while (cast != 0) {
    count += cast & 1; /**add lsb to counter*/
    cast >>= 1;        /** right-shift by one position to discard lsb*/
  }
  return count;
}