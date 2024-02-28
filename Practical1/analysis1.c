/* Author: Megan Avery - Spring 2024

Q: Explain what this code is doing. What values does nums 
contain if the user enters 1, 4, 5, 7?

*/

#include <stdio.h>
#include <stdlib.h>

#define SIZE 4
#define FACTOR 2

int main() {
    float* nums = calloc(SIZE, sizeof(float));

    // input: 1, 4, 5, 7
    for (int i = 0; i < SIZE; ++i) {
        float current;
	  printf("Enter number #%d: ", (i + 1));
	  scanf("%f", &current);

	  *(nums + i) = current * FACTOR;
    }

    free(nums);
}
