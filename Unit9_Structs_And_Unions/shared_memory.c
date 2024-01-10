/*
 * Driver file for array1.asm file
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stddef.h>

union SameBits {
	char c;
	short s;
	int i;
	float f;
};

void print_same_bits(char* title, union SameBits same_bits);
void bin(unsigned n, int num_bits, bool is_char, bool is_float);

int main()
{
	union SameBits same_bits;

	same_bits.c = 'A';
	char c_title[] = "Making c 'A'\n";
	print_same_bits(c_title, same_bits);
	printf("\n");

	same_bits.s = 954;
	char s_title[] = "Making s 954\n";
	print_same_bits(s_title, same_bits);
	printf("\n");

	same_bits.i = 1345577;
	char i_title[] = "Making i 1345577\n";
	print_same_bits(i_title, same_bits);
	printf("\n");

	same_bits.f = 3.4;
	char f_title[] = "Making f 3.4\n";
	print_same_bits(f_title, same_bits);
	printf("\n");

	same_bits.i = 3456;
	same_bits.c = 'T';
	char multiple_title[] = "Change int then char\n";
	print_same_bits(multiple_title, same_bits);
}


void print_same_bits(char* title, union SameBits same_bits) {
	printf("%s", title);
	printf("\tchar c: %c\n\t\t", same_bits.c);
	bin(same_bits.c, 8, true, false);

	printf("\tshort s: %d\n\t\t", same_bits.s);
	bin(same_bits.s, 16, false, false);

	printf("\tint i: %d\n\t\t", same_bits.i);
	bin(same_bits.i, 32, false,false);

	printf("\tfloat f: %f\n\t\t", same_bits.f);
	bin(same_bits.i, 32, false, true);
}

void bin(unsigned n, int num_bits, bool is_char, bool is_float)
{
    unsigned num_dashes, i, bits_from_left;

	num_dashes = 32 - num_bits;
	for (i = 0; i < num_dashes; ++i)
		printf("-");
	printf("|");

	int target_bit = num_bits - 1;

	if (!is_char) {
		i = 1 << target_bit;
		(n & i) ? printf("1|") : printf("0|");

		target_bit--;
	}

	bits_from_left = 0;
    for (i = 1 << target_bit; i > 0; i = i / 2) {
        (n & i) ? printf("1") : printf("0");
		if (is_float && bits_from_left == 7)
			printf("|");
		bits_from_left++;
	}
	printf("\n");
}




