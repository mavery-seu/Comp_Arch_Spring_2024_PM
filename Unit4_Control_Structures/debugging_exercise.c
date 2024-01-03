// Author: Megan Avery - Spring 2024
//
// Purpose: to help walk through the debugger

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FIB 30

// RECURSIVE FUNCTION
int fib(int num) {
	if (num < 2) {
		return num;
	}

	return fib(num - 1) + fib(num - 2);
}

// FUNCTIONS THAT CALL FUNCTIONS
int fourthLayer(int num) {
	return 4 * num;
}

int thirdLayer(int num) {
	return 3 * num + fourthLayer(num);
}

int secondLayer(int num) {
	return 2 * num + thirdLayer(num);
}

int firstLayer(int num) {
	return num + secondLayer(num);
}

// FUNCTION WITH A LOOP
int reverseNumber(int num) {
	int answer = 0;
	
	while (num != 0) {
		answer *= 10;
		answer += num % 10;

		num = num / 10;
	}

	return answer;
}

// FUNCTION WITH A POINTER
void pointerExample(int num) {
	int* numCopyPtr = malloc(sizeof(int));

	*numCopyPtr = num;

	printf("\nNum Copy Ptr: %p - %d\n", numCopyPtr, *numCopyPtr);

	free(numCopyPtr);
}

int main(int arc, char* argv[]) {
	int num;
	printf("Enter a number: ");
	scanf("%d", &num);

	int answer;
	if (num <= MAX_FIB) {
		answer = fib(num);
		printf("\nFib number #%d: %d\n", num, answer);
	} else {
		printf("\nOops, too big for recursive fib 😿\n");
	}

	answer = firstLayer(num);
	printf("\nLayered answer: %d\n", answer);

	answer = reverseNumber(num);
	printf("\n%d reversed is %d\n", num, answer);

	pointerExample(num);
}
