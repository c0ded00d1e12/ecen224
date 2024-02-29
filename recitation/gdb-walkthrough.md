---
title: Gdb Walkthrough
layout: walkthrough
permalink: /:path/:basename
---
So far, we have been using gcc to compile C code into executable programs and, occasionally, into assembly language. For the upcoming homework and labs it we need to expand our palette to include `objdump` and `gdb`.

To get started, you need to make sure the tools are installed in your Linux installation (whether a physical machine, a VM, or Windows Subsystem for Linux). *If you are using a lab computer, everything is already there.* For other cases, use the following commands to install the tools:
```
sudo apt update
sudo apt install gcc build-essential
sudo apt install gcc-multilib
sudo apt install gdb
```

*gcc-multilib* lets you compile for 32-bit as well as 64-bit.
*gdb* installs the debugger.

## **gcc** Compiler/Linker
Compiles code in C, C++, and a variety of other languages and links code from multiple modules and libraries into an executable file.

### Commonly-used options
* `-m32`<br/>Compile and link for 32-bit mode
* `-O0`<br/>Turn off all optimizations. Usually this makes assembly code easier to read and debug. (That's capital "O" followed by zero.)
* `-O1` `-O2` `-O3`<br/>Add varying degrees of optimization. These certainly make the code more efficient and sometimes make it easier to understand.
* `-Os`<br/>Optimize for size (instead of performance). This may also make the generated code more intelligible.
* `-S`<br/>Compile to assembly language - to see how things are done. (That's a capital 'S'.)
* `-S -masm=intel`<br/>Compile to intel-syntax assembly language. 
* `-S -masm=att`<br/>Compile to AT&T-syntax assembly language. (Not really necessary because that's the default.)
* `-c`<br/>Compile to an object file to be linked or dumped.
* `-fno-asynchronous-unwind-tables -fno-pie -mpreferred-stack-boundary=3`<br/>Remove extra stuff from the generated code so you can see just what the compiler is doing. For details on what these mean see [this article](https://stackoverflow.com/questions/38552116/how-to-remove-noise-from-gcc-clang-assembly-output), [this article](https://stackoverflow.com/questions/50105581/how-do-i-get-rid-of-call-x86-get-pc-thunk-ax), and [this article](https://stackoverflow.com/questions/10251203/gcc-mpreferred-stack-boundary-option) from StackOverflow.
* `-fverbose-asm`
* `-ggdb`<br/>Include debugging symbols 

### Example

Create a file called `add.c` with the following contents:
```
int add(int a, int b)
{
  return a + b;
}
```

Compile it to assembly using the following command:
```
gcc -m32 -O0 -S -fno-asynchronous-unwind-tables -fno-pie -mpreferred-stack-boundary=3 add.c
```

This will produce a file called `add.s` with the assembly language version of the code.

Try the same thing without the -m32 option to see how 64-bit code differs from the 32-bit version.

## **objdump** Object and executable file dump tool
Dumps the contents of object and executable files including disassembling machine code.

> *Disassembling* means to take machine code and convert it into the equivalent assembly-language code. It's very useful when you don't have access to the source code of a program and you want to *reverse engineer* it to figure out how it works. You will need to disassemble code to complete the upcoming *bomb* and *attack* labs. 

### Commonly-used options
* `-d`<br/>Disassemble all .text (code) sections.
* `-M intel`<br/>Use Intel syntax when disassembling code.
* `-s`<br/>Binary dump all sections.

### Example

Use the same `add.c` file from the **gcc** example. Compile it to an object file with the following command:

```
gcc -O0 -c -fno-asynchronous-unwind-tables -fno-pie add.c
```
This produces an *object* (machine-language) file called `add.o`.

Now dump the contents using the following command:

```
objdump -d -s add.o
```

You will notice that the object file has three sections. The `.text` section contains the machine code. Since we used both the -d and the -s options, it also disassembles the .txt section to show us the assembly language version. If you look at the hexadecimal dump of the `.text` section it's the same as the hexadecimal machine language to the left of the disassembled code. I think you'll agree that it's much easier to interpret the assembly language than the machine language.

## **gdb** GNU Debugger
Loads a program and lets you examine it while running including setting breakpoints, examining register contents, examining variables, changing values and so forth.

We can only get you started in this document. More detail can be found here: [GDB Step By Step Introduction](https://www.geeksforgeeks.org/gdb-step-by-step-introduction/).

### Command line
Start gdb by specifying the program to be debugged on the command line.
* **gdb** a.out

Once it's running you type commands to debug the code.

### Common commands
* `set disassembly-flavor intel`<br/>Disassemble in Intel syntax
* `set disassembly-flavor att`<br/>Disassemble in AT&T syntax (this is the default)
* `disassemble <name>`<br/>Disassemble the named function
* `list`<br/>List the source code in the vicinity of the current location.
* `break <name>`<br/>Set a breakpoint on the named function
* `break *<address>`<br/>Set a breakpoint at the specified address
* `run`<br/>Start the program from the beginning
* `continue`<br/>Continue running the program after reaching a breakpoint
* `step`<br/>Go to the next instruction, diving into functions when called
* `next`<br/>Go to the next instruction, skipping over function calls
* `exit`<br/>Exit the debugger

### Example
Create a file called `add.c` with the following contents:
```
#include <stdio.h>

int add(int a, int b)
{
  return a + b;
}

int main(int argc, char **argv)
{
  printf("%d\n", add(3,5));
}
```

Compile and link the program with the following command:
```
gcc -m32 -O0 -fno-asynchronous-unwind-tables -fno-pie -ggdb add.c
```

Load the program into the debugger and try a few commands:
```
gdb a.out
disassemble add
disassemble main
break add
run
list
info registers
backtrace
continue
```
