#include <stdio.h>
#include <stdlib.h>

#include "cdecl.h"

void PRE_CDECL get_float( FILE*, float* ) POST_CDECL;
void PRE_CDECL get_trapezoid_area(float, float, float, float*) POST_CDECL;

int main( void )
{
  float baseA, baseB, height, area;

// user inputs
  printf("Base A: ");
  get_float(stdin, &baseA);

  printf("Base B: ");
  get_float(stdin, &baseB);

  printf("Height: ");
  get_float(stdin, &height);

  get_trapezoid_area(baseA, baseB, height, &area);
  printf("\nArea: %f", area);

  return 0;
}
