#!/bin/bash

# Define color codes for output messages
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Check if lex and yacc files are provided as arguments
if [ "$#" -ne 2 ]; then
    echo -e "${RED}Usage: $0 <lex_file> <yacc_file>${RESET}"
    exit 1
fi

LEX_FILE=$1
YACC_FILE=$2

# Check if the provided files exist
if [ ! -f "$LEX_FILE" ]; then
    echo -e "${RED}Error: Lex file '$LEX_FILE' not found!${RESET}"
    exit 1
fi

if [ ! -f "$YACC_FILE" ]; then
    echo -e "${RED}Error: Yacc file '$YACC_FILE' not found!${RESET}"
    exit 1
fi

# Get the directory and base name of the files
DIR=$(dirname "$LEX_FILE")
BASE_NAME=$(basename "$LEX_FILE" .lex)

# Change to the directory containing the files
cd "$DIR"

# Get the base names without directory paths
LEX_BASE_NAME=$(basename "$LEX_FILE")
YACC_BASE_NAME=$(basename "$YACC_FILE")

# Parse the yacc file
yacc -d "$YACC_BASE_NAME"
if [ $? -ne 0 ]; then
    echo -e "${RED}Yacc parsing failed!${RESET}"
    exit 1
fi

# Parse the lex file using lex
lex "$LEX_BASE_NAME"
if [ $? -ne 0 ]; then
    echo -e "${RED}Lex parsing failed!${RESET}"
    exit 1
fi

# Compile the C source files using gcc
EXECUTABLE="${BASE_NAME}_exec"
gcc lex.yy.c y.tab.c -lfl -o "$EXECUTABLE"

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Lex and Yacc files ${CYAN}'$LEX_FILE'${GREEN} and ${CYAN}'$YACC_FILE'${GREEN} have been compiled to ${CYAN}'$DIR/$EXECUTABLE'${GREEN}.${RESET}"
else
    echo -e "${RED}Compilation failed!${RESET}"
    exit 1
fi

# Clean up the generated C files
rm lex.yy.c y.tab.c y.tab.h

# Return to the original directory
cd - > /dev/null
