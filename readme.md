# NASM Sample Code

## What this repo covered

1. Block-Structured If Statement: Checks a number and prints if it is positive, negative, or zero.
2. Compound Expressions with AND: Checks if a number is between 1 and 10.
3. Compound Expressions with OR: Checks if a number is either less than 1 or greater than 10.
4. While Loop: Sums numbers from 1 to 5.
5. Table-Driven Selection: Uses a table to select and print a message based on an index.

## Run the program

```bash
nasm -f elf64 program.asm -o program.o
ld program.o -o program
./program

## I will regularly update the repository
