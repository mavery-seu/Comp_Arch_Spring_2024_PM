/* Author: Megan Avery - Spring 2024

Q: The programmer expected the “Echo!” to be followed by the word 
the user entered. Why did they end up with gobbledygook instead?

*/

#include <stdio.h>
#include <stdlib.h>

int main() {

	char* str = calloc(16, sizeof(char));

	printf("Enter a word: ");
	scanf("%15s", str);

	free(str);

	printf("Echo! %s", str);
}

