#include <stdio.h>

int countBits(int num);

/* This is a comment */
int main(void) {
  int num;
  char prompt = 'y';
  int count;
  unsigned int cast;
  printf("Welcome to the CountOnes program.\n");

  while (prompt != 'n') {
    printf("\nPlease enter a number: ");
    scanf("%d", &num);
    count = 0;
    cast = (unsigned int)num; /*cast to unsigned int*/
    while (cast != 0) {
      count += cast & 1; /**add lsb to counter*/
      cast >>= 1;        /** right-shift by one position to discard lsb*/
    }
    printf("The number of bits set is: %d\n", count);
    printf("Continue (y/n)?: ");
    scanf(" %c", &prompt);
  }
  printf("Exiting");
  return 0;
}