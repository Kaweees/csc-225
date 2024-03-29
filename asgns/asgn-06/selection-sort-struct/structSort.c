#include <stdio.h>
#define SIZE 10
typedef struct Node studentNode;
void swap(studentNode *arr, int i, int j);
void selectionSort(studentNode *arr, int i, int n);
void printArray(studentNode *arr, int n);

/* A character is one byte, an integer is 4 bytes, and a pointer is 8 bytes.
 * Therefore, the size of a node is 18 bytes. */
struct Node { /* 14 bytes */
  /* Padding */
  char name[6];  /* 5 bytes for 5 characters, 1 byte for null character */
  int studentid; /* 4 bytes */
  int coursenum; /* 4 bytes */
};

studentNode studentlist[SIZE] = {{"Dougy", 13, 2122}, {"Timmy", 15, 2122},
    {"Emily", 18, 2123}, {"Jimmy", 14, 2120}, {"Kimmy", 11, 2123},
    {"Carlo", 19, 2123}, {"Vicky", 22, 2120}, {"Anton", 12, 2322},
    {"Brady", 10, 2120}, {"Sonya", 16, 2123}};

int main() {
  int n = SIZE;
  selectionSort(studentlist, 0, n);
  printArray(studentlist, n);

  return 0;
}

/* Utility function to swap values at two indices in an array*/
void swap(studentNode arr[], int i, int j) {
  studentNode temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
void selectionSort(studentNode arr[], int i, int n) {
  /* find the minimum element in the unsorted subarray `[i…n-1]`
  // and swap it with `arr[i]`  */
  int j;
  int min = i;
  for (j = i + 1; j < n; j++) {
    /* if `arr[j]` is less, then it is the new minimum */
    if (arr[j].studentid < arr[min].studentid) {
      min = j; /* update the index of minimum element */
    }
  }

  /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
  swap(arr, min, i);

  if (i + 1 < n) {
    selectionSort(arr, i + 1, n);
  }
}

/* Function to print `n` elements of array `arr` */
void printArray(studentNode arr[], int n) {
  int i;
  for (i = 0; i < n; i++) {
    printf("%d ", arr[i].studentid);
    printf("%s ", arr[i].name);
    printf("%d\n", arr[i].coursenum);
  }
}
