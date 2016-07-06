typedef struct {
  char **array;
  size_t used;
  size_t size;
  char *probability;
} Array;

typedef struct {
  Array *array;
  size_t used;
  size_t size;
} TwoDimensionalArray;

void initArray(Array *, size_t);
void insertArray(Array *, char *);
void freeArray(Array *);

void init2DArray(TwoDimensionalArray *, size_t);
void insert2DArray(TwoDimensionalArray *, Array);
void free2DArray(TwoDimensionalArray *);
