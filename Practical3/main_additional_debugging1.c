#include <stdio.h>
#include <stdlib.h>

#include "cdecl.h"

#define NUM_LENGTH 6

void PRE_CDECL print_every_nth_number(int*, int, int) POST_CDECL;

int main( void )
{
  int numbers[NUM_LENGTH] = {10, 11, 12, 13, 14, 15};

  print_every_nth_number(numbers, NUM_LENGTH, 2);

  return 0;
}
