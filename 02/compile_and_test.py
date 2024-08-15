import os, sys
import subprocess

# Define color codes for output messages
RED     = '\033[0;31m'
GREEN   = '\033[0;32m'
PURPLE  = '\033[0;35m'
CYAN    = '\033[0;36m'
RESET   = '\033[0m'

# Predefined paths
lex_file             = "tokenizer.lex"
yacc_file            = "parser.yacc"
executable           = "./prog_exec"
input_file           = "_input.txt"
expected_output_file = "_expected_output.txt"

# Check if the files exist
def check_file_exists(file_path, description):
    if not os.path.isfile(file_path):
        print(f"{RED}Error: {description} '{file_path}' not found!{RESET}")
        sys.exit(1)

check_file_exists(lex_file,             "Lex file")
check_file_exists(yacc_file,            "Yacc file")
check_file_exists(input_file,           "Input file")
check_file_exists(expected_output_file, "Expected output file")

# Compile the lex and yacc files
def compile_files():
    try:
        # Compile yacc file
        subprocess.run(["yacc", "-d", yacc_file], check=True)
        # Compile lex file
        subprocess.run(["lex", lex_file], check=True)
        # Compile the C source files
        subprocess.run(["gcc", "lex.yy.c", "y.tab.c", "-lfl", "-lm", "-o", executable], check=True)
        print(f"{GREEN}Compilation successful.{RESET}")
    except subprocess.CalledProcessError:
        print(f"{RED}Compilation failed!{RESET}")
        sys.exit(0)

# Run the test
def run_test():
    # Run the executable with the input file and capture the output
    with open(input_file, 'r') as infile:
        actual_output = subprocess.run(
            [executable],
            stdin=infile,
            capture_output=True,
            text=True
        ).stdout

    # Read the expected output
    with open(expected_output_file, 'r') as reader:
        expected_output = reader.read()
    
    # read input file
    with open(input_file, 'r') as reader:
        input_lines = reader.read().splitlines()

    # Split the outputs into lines
    actual_output_lines = actual_output.splitlines()
    expected_output_lines = expected_output.splitlines()

    # Compare the actual output with the expected output line by line
    test_passed = True
    for i, (actual_line, expected_line, input_line) in enumerate(zip(actual_output_lines, expected_output_lines, input_lines), start=1):
        if actual_line != expected_line:
            print(f"{RED}Test failed at line {i}: {PURPLE}{input_line}{RESET}")
            print(f"{CYAN}Actual output:   `{actual_line}`{RESET}")
            print(f"{CYAN}Expected output: `{expected_line}`{RESET}")
            test_passed = False

    if len(actual_output_lines) != len(expected_output_lines):
        print(f"{RED}Test failed: Output lengths differ.{RESET}")
        print(f"{RED}Actual lines={len(actual_output_lines)}  |  Expected lines={len(expected_output_lines)}{RESET}")
        test_passed = False

    if test_passed:
        print(f"{GREEN}Test passed: Output matches the expected output.{RESET}")
    else:
        # save output
        with open('_failed_output.txt', 'w') as writer:
            for line in actual_output_lines:
                writer.write(line + '\n')

# Main function
if __name__ == "__main__":
    compile_files()
    run_test()

    # Clean up generated files
    cleanup_files = ["lex.yy.c", "y.tab.c", "y.tab.h"]
    for file in cleanup_files:
        if os.path.isfile(file):
            os.remove(file)
