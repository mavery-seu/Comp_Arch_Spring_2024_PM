// Sample code analysis for Exam 3 - Spring 2024


/*
What is the output for this piece of code? How much padding does that 
equate to in the struct? How might you rearrange the elements in the
Thing struct to reduce the amount of padding required?
*/
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stddef.h>

#define NICKNAME_MAX 5
#define HEX_CODE_LENGTH 7

struct Thing {
	char nickname[NICKNAME_MAX];
	short number;
	char shirt_color[HEX_CODE_LENGTH];
	int age;
};

int main() {
	struct Thing thing1;

	printf("Nickname Offset: %lu\n", offsetof(struct Thing, nickname));
	printf("Number offset: %lu\n", offsetof(struct Thing, number));
	printf("Shirt Color offset: %lu\n", offsetof(struct Thing, shirt_color));
	printf("Age offset: %lu", offsetof(struct Thing, age));
}




