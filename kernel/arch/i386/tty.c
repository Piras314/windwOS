#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include <kernel/tty.h>

#include "vga.h"

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

static uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;

static size_t term_row;
static size_t term_col;
static uint8_t term_colour;
static uint16_t* term_buffer;

void term_init(void) {
	term_row = 0;
	term_col = 0;

	term_colour = vga_entry_colour(VGA_COLOUR_LIGHT_GREY, VGA_COLOUR_BLACK);
	term_buffer = VGA_MEMORY;

	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;

			term_buffer[index] = vga_entry(' ', term_colour);
		}
	}
}

void term_setcolour(uint8_t colour) {
	term_colour = colour;
}

void term_putcat(unsigned char c, uint8_t colour, size_t x, size_t y) {
	const size_t index = y * VGA_WIDTH + x;

	term_buffer[index] = vga_entry(c, colour);
}

void term_putc(char c) {
	unsigned char uc = c;

	term_putcat(uc, term_colour, term_col, term_row);

	if (++term_col == VGA_WIDTH) {
		term_col = 0;

		if (++term_row == VGA_HEIGHT) {
			term_row = 0;
		}
	}
}

void term_write(const char* data, size_t size) {
	for (size_t i = 0; i < size; i++) {
		term_putc(data[i]);
	}
}

void term_writestring(const char* data) {
	term_write(data, strlen(data));
}
