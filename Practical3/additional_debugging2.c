// Sample code analysis for Exam 3 - Spring 2024

// This code compiles and runs but... it the results are making
// any sense to the programmer. What property of unions did they likely
// forget and why is that a problem in this situation (in detail).

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stddef.h>

#define NICKNAME_MAX 5
#define HEX_CODE_LENGTH 7

union AllTogetherNow {
	int width;
	int height;
	int depth;
};

int main() {
	union AllTogetherNow details;

	details.width = 12;
	details.height = 45;
	details.depth = 61;

	// more code manipulating the union and printing its contents
}




