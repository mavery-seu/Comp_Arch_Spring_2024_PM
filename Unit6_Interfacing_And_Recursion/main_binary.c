/*
 * Author: Megan Avery Spring 2024
 */

#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL binary_to_base10( int ) POST_CDECL; /* prototype for assembly routine */
int PRE_CDECL count_ones( int ) POST_CDECL; /* prototype for assembly routine */

int main( void )
{
  int original_number, decimal_rep, num_ones;

  printf("Enter a binary number: ");
  scanf("%d", &original_number);

  decimal_rep = binary_to_base10(original_number);
  printf("\n%d in base 10 is: %d\n", original_number, decimal_rep);

  num_ones = count_ones(decimal_rep);
  printf("%d has %d 1s in it!", original_number, num_ones);

  return 0;
}
