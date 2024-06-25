#!/bin/bash

# Define color codes for output messages
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Check if a lex file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo -e "${RED}Usage: $0 <lex_file>${RESET}"
    exit 1
fi

LEX_FILE=$1

# Check if the provided file exists
if [ ! -f "$LEX_FILE" ]; then
    echo -e "${RED}Error: File '$LEX_FILE' not found!${RESET}"
    exit 1
fi

# Get the directory and base name of the lex file
DIR=$(dirname "$LEX_FILE")
BASE_NAME=$(basename "$LEX_FILE" .l)

# Parse the lex file using lex
OUTPUT_C_FILE="$DIR/$BASE_NAME.c"
lex -o "$OUTPUT_C_FILE" "$LEX_FILE"

# Compile the C source file using gcc
EXECUTABLE="$DIR/${BASE_NAME}_exec"
gcc "$OUTPUT_C_FILE" -lfl -o "$EXECUTABLE"

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Lex file ${CYAN}'$LEX_FILE'${GREEN} has been compiled to ${CYAN}'$EXECUTABLE'${GREEN}.${RESET}"
else
    echo -e "${RED}Compilation failed!${RESET}"
    exit 1
fi

# Clean up the generated C file
rm "$OUTPUT_C_FILE"
