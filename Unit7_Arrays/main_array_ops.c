/*
 * Author: Megan Avery Spring 2024
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "cdecl.h"

#define SUBSTRING 1
#define REVERSE 2
#define CONCAT 3
#define PALINDROME 4

#define MAX_SIZE 16

void PRE_CDECL print_substring(char*, int, int) POST_CDECL;

void PRE_CDECL reverse_into_buffer(char*, char*, int) POST_CDECL;

void PRE_CDECL concatenate_strings(char*, int, char*, int, char*) POST_CDECL;

int PRE_CDECL is_palindrome(char*, int) POST_CDECL;


int main( void )
{
  int choice;	

  char input1[MAX_SIZE];
  int substring_start;
  int substring_end;

  char input1_reversed[MAX_SIZE];
  
  char input2[MAX_SIZE];
  char concat_result[MAX_SIZE * 2];

  printf("-------------------------------------------------\n");
  printf("Let's an array operation!\n");
  printf("-------------------------------------------------\n");
  printf("What would you like to do?\n");
  printf("\t%d) Substring\n", SUBSTRING);
  printf("\t%d) Reverse a string\n", REVERSE);
  printf("\t%d) Concatenation 2 strings\n", CONCAT);
  printf("\t%d) Determine if a string is a palindrome\n", PALINDROME);

  printf("-------------------------------------------------\n");
  printf("Enter your choice: ");
  scanf("%d", &choice);
  printf("-------------------------------------------------\n");
  
  switch (choice) {
  	case SUBSTRING:
		printf("Enter a string: ");
		scanf("%s", input1);
		printf("Enter start of substring: ");
		scanf("%d", &substring_start);
		printf("Enter end of substring: ");
		scanf("%d", &substring_end);

		printf("\nSubstring: ");
		print_substring(input1, substring_start, substring_end);
		printf("\n");
		break;
	case REVERSE:
		printf("Enter a string to reverse: ");
		scanf("%s", input1);
		int size_of_input = strlen(input1);

		reverse_into_buffer(input1, input1_reversed, size_of_input);
		printf("Reversed string: %s\n", input1_reversed);
		break;
	case CONCAT:
		printf("Enter first string: ");
		scanf("%s", input1);
		printf("Enter second string: ");
		scanf("%s", input2);

		int input1_size = strlen(input1);
		int input2_size = strlen(input2);

		concatenate_strings(input1, input1_size, input2, input2_size, concat_result);
		printf("Resultig string: %s\n", concat_result);
		break;
	case PALINDROME:
		printf("Enter a word: ");
		scanf("%s", input1);

		int is_a_palindrome = is_palindrome(input1, strlen(input1));
		if (is_a_palindrome) 
			printf("Nice! A palindrome\n");
		else
			printf("Better look next time\n");
		break;
	default:
		printf("Oops! Not a valid choice\n");
  }
  printf("-------------------------------------------------\n");
  

  return 0;
}
