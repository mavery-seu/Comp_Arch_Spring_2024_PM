/*
 * Author: Megan Avery Spring 2024
 */

#include <stdio.h>
#include <stdlib.h>

#include "cdecl.h"

extern int SIN;
extern int COS;
extern int TAN;

void PRE_CDECL get_float( FILE*, float* ) POST_CDECL;

void PRE_CDECL calculate_hypotenuse(float, float, float*) POST_CDECL;

void PRE_CDECL calculate_area(float, float, float*) POST_CDECL;

void PRE_CDECL calculate_sohcahtoa(float, float, float, float*, int) POST_CDECL;

void PRE_CDECL get_perimeter(float, float, float*);

void PRE_CDECL get_trapezoid_area(float, float, float, float*) POST_CDECL;

int main( void )
{
  float leg_1, leg_2, hypotenuse, area, answer;

// user inputs
  printf("Enter leg 1: ");
  get_float(stdin, &leg_1);

  printf("Enter leg 2: ");
  get_float(stdin, &leg_2);

// perimeter calculation
  float perimeter;
  get_perimeter(leg_1, leg_2, &perimeter);
  printf("\nPerimeter: %f\n", perimeter);

// hypotenuse calculation
  calculate_hypotenuse(leg_1, leg_2, &hypotenuse);
  printf("\nHypotenuse: %.2f\n", hypotenuse); 

// area calculation
  calculate_area(leg_1, leg_2, &area);
  printf("\nArea: %.2f\n", area);

// soh cah toa calculations
  calculate_sohcahtoa(leg_1, leg_2, hypotenuse, &answer, SIN);
  printf("\tsin: %.2f\n", answer);
  
  calculate_sohcahtoa(leg_1, leg_2, hypotenuse, &answer, COS);
  printf("\tcos: %.2f\n", answer);
  
  calculate_sohcahtoa(leg_1, leg_2, hypotenuse, &answer, TAN);
  printf("\ttan: %.2f\n", answer);

  return 0;
}
