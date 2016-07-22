#include <stdlib.h>
#include <stdio.h>
#include "dynamicarray.h"

void initArray(Array *a, size_t initialSize) {
  a->array = (char **) malloc (initialSize * sizeof(char *));
  a->used = 0;
  a->size = initialSize;
  a->probability = NULL;
}

void insertArray(Array *a, char *element) {
  if (a->used == a->size) {

  	if (a->size!=0) {
	    a->size *= 2;
    }
    else
    {
	    a->size = 1;
    }

    a->array = (char **)realloc(a->array, a->size * sizeof(char *));
  }
  a->array[a->used++] = element;
}

void freeArray(Array *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}

void init2DArray(TwoDimensionalArray *a, size_t initialSize) {
  a->array = (Array *)malloc(initialSize * sizeof(Array));
  a->used = 0;
  a->size = initialSize;
}

void insert2DArray(TwoDimensionalArray *a, Array element) {
  if (a->used == a->size) {
    a->size *= 2;
    a->array = (Array *)realloc(a->array, a->size * sizeof(Array));
  }
  a->array[a->used++] = element;
}

void free2DArray(TwoDimensionalArray *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}
