## Assignment Details
## Project 6: Stack-Based Expression Evaluation

A detailed writeup can be found [here↗](github.com/timmprice)

You will convert a C# program that evaluates mathematical expressions using a stack (postfix notation) into MASM assembly code. This project includes implementing stack operations and parsing strings

### Instructions
- Write a C# program that evaluates a postfix expression using a stack.
- Convert the program to MASM, implementing push and pop stack operations and parsing input strings.
- Evaluate the expression and display the result.

### MASM Implementation Notes
- Implement a stack in memory, managing pushes and pops with stack pointer manipulations. - Parse the postfix expression and execute operations based on stack state.

### <---- Running source code ---->
I have included several assembly files that serve each different purpose. ”main.asm” contains the original assembly source code, ”extra.asm” contains extra API calls to write the result as a string to the console and comes with a power-shell script to assemble and link with the MASM-SDK which is required, and in a sub-directory called timing there is ”time.asm” and its accompanying power-shell script to measure the throughput and latency of my masm program. The C# directory is self explanatory and can be run most easily by using the CLI and executing "dotnet run".

#### Team Members
Tim Price

