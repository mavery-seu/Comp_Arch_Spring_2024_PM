/*
 * Author: Megan Avery
 * Spring 2023 */
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stddef.h>

#define STRING_MAX 27

union PillowPet {
	char name[STRING_MAX];
	char animal[STRING_MAX];
	int size;
};

struct InfoHolder {
	char letter;
	short small_whole_number;
	int whole_number;
	float decimal;
	char str[10];
};

void set_hard_coded_pillow_pet(union PillowPet* hard_coded);
void print_pillow_pet(union PillowPet pillow_pet);

int main()
{
	union PillowPet hard_coded;

	set_hard_coded_pillow_pet(&hard_coded);
	print_pillow_pet(hard_coded);

}

void set_hard_coded_pillow_pet(union PillowPet* hard_coded) {
	strcpy(hard_coded->name, "Topper the Goat");
	strcpy(hard_coded->animal, "hilltopper");
	
	hard_coded->size = 42;
}

void print_pillow_pet(union PillowPet pillow_pet) {
	printf("Name: %s\n", pillow_pet.name);
	printf("Animal: %s\n", pillow_pet.animal);

	printf("Size: %d\n", pillow_pet.size);
}



