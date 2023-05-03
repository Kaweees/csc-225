#include <stdio.h>

#include "operations.h"

int main(void) {
  char prompt = 'y';
  int operation;
  int count = 0;
  int num1;
  int num2;
  unsigned int cast;
  printf("Welcome to the Calculator program.\n");
  printf(
      "Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor "
      "8:lshift 9:rshift\n");

  while (prompt != 'n') {
    printf("\nNumber of operations performed: %d", count);
    printf("\nEnter number: ");
    scanf("%d", &num1);
    printf("\nEnter second number: ");
    scanf("%d", &num1);
    printf("\nSelect operation: ");
    scanf("%d", &operation);
    switch (operation) {
      case 1:
        printf("Result: %d\n", addnums(num1, num2));
        break;
      case 2:
        printf("Result: %d\n", subnums(num1, num2));
        break;
      case 3:
        printf("Result: %d\n", multnums(num1, num2));
        break;
      case 4:
        printf("Result: %d\n", divnums(num1, num2));
        break;
      case 5:
        printf("Result: %d\n", andnums(num1, num2));
        break;
      case 6:
        printf("Result: %d\n", ornums(num1, num2));
        break;
      case 7:
        printf("Result: %d\n", xornums(num1, num2));
        break;
      case 8:
        printf("Result: %d\n", lshiftnums(num1, num2));
        break;
      case 9:
        printf("Result: %d\n", rshiftnums(num1, num2));
        break;
      default:
        printf("Result: Invalid Operation\n");
        break;
    }
    printf("Continue (y/n)?: ");
    scanf(" %c", &prompt);
    count++;
  }
  printf("Exiting");
  return 0;
}
