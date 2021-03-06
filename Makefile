#
# 	CAB202 Tutorial 9
#	Generic Makefile for compiling with floating point printf
#
#	B.Talbot, September 2015
#	Queensland University of Technology
#

# Modify these
NAME=snake
SRC=snake.c
CAB202_LIB_DIR=cab202_teensy

# The rest should be all good as is
FLAGS=-flto -mmcu=atmega32u4 -Os -DF_CPU=8000000UL -std=gnu99 -Wall -Werror
LIBS=-Wl,-u,vfprintf -lprintf_flt -lcab202_teensy -lm

DEBUG_LIB_DIR=usb_debug_only
DEBUG_FLAGS=-DUSB_DEBUG -I$(DEBUG_LIB_DIR) -L$(DEBUG_LIB_DIR)
DEBUG_LIBS=-lexample

# Default 'recipe'
release:
	avr-gcc $(SRC) $(FLAGS) -I$(CAB202_LIB_DIR) -L$(CAB202_LIB_DIR) $(LIBS) -o $(NAME).o
	avr-objcopy -O ihex $(NAME).o $(NAME).hex

# Cleaning  (be wary of this in directories with lots of executables...)
clean:
	rm *.o
	rm *.hex

# Debug
debug:
	avr-gcc $(SRC) $(FLAGS) $(DEBUG_FLAGS) -I$(CAB202_LIB_DIR) -L$(CAB202_LIB_DIR) $(LIBS) $(DEBUG_LIBS) -o $(NAME)-debug.o
	avr-objcopy -O ihex $(NAME)-debug.o $(NAME)-debug.hex