/*
 * Author: Paul Carter
 */

#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL quadratic( double, double, double, double *, double *) POST_CDECL;

int main()
{
  double a,b,c, root1, root2;

  printf("Enter a, b, c: ");
  scanf("%lf %lf %lf", &a, &b, &c);
  if (quadratic( a, b, c, &root1, &root2) )
    printf("roots: %.4g %.4g\n", root1, root2);
  else
    printf("No real roots 😭");
  return 0;
}

