/*
 * Original by Carter
 * Updated by Megan Avery Spring 2023
 * file: memex.c
 */

#include <stdio.h>

#include "cdecl.h"

#define STR_SIZE 30
/*
 * prototypes
 */

void PRE_CDECL asm_copy( void *, 
                         const void *,
                         unsigned ) POST_CDECL;

void * PRE_CDECL asm_find_address_of( const void *,
                           char target,
                           unsigned ) POST_CDECL;

int PRE_CDECL asm_find_index_of( const void *,
                           char target,
                           unsigned ) POST_CDECL;

unsigned PRE_CDECL asm_strlen( const char * ) POST_CDECL;

void PRE_CDECL asm_strcpy( char *,
                           const char * ) POST_CDECL;

int main()
{
  char original[STR_SIZE] = "Fear_the_Goat!";
  char copy[STR_SIZE];
  char * address_of_char;
  char   ch;
  int index_of_char;

  printf("Original string: %s\n\n", original);

  asm_copy(copy, original, STR_SIZE);   /* copy all 30 chars of string */
  printf("Copied using asm_copy\n");
  printf("\tOriginal: %s\n", original);
  printf("\tCopy: %s\n\n", copy);

  printf("Enter a char to search for: ");  /* look for byte in string */
  scanf("%c%*[^\n]", &ch);
  address_of_char = asm_find_address_of(copy, ch, STR_SIZE);
  index_of_char = asm_find_index_of(copy, ch, STR_SIZE);
  if ( address_of_char ) {
    printf("\tFound at address: %p\n", address_of_char);
	printf("\tFound at index: %d\n", index_of_char);
  } else
    printf("\t%c not in string!\n", ch);

  original[0] = 0;		/* make original an empty string */
  printf("\nEnter new string: ");
  scanf("%s", original);
  printf("\tString is %u characters long\n", asm_strlen(original));

  asm_strcpy(copy, original);     /* copy meaningful data in string */
  printf("\tCopied using asm_strcpy\n");
  printf("\t\tOriginal: %s\n", original);
  printf("\t\tCopy: %s\n", copy);

  return 0;
}

