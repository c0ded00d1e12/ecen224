---
title: Debugging
number: 5
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Slack channel for the lab to accept the assignment.

## Objectives

- Become familiar with the different styles of debugging
- Become familiar with GDB through VSCode and the terminal
- Gain exposure of analyzing the assembly of a compiled C program

## Overview

Debugging is an essential part of software development, and debugging in C programming language requires a combination of tools and techniques to identify and fix errors in the code. The process of debugging involves identifying the cause of the problem, developing a hypothesis, testing the hypothesis, and implementing a solution. By using intentional and incremental programming, print statements, and GDB, you can effectively debug your programs and ensure that they run as expected.

### Intentional and Incremental Programming
Intentional and incremental programming are two important mindsets to have while diving into software development. Intentional programming is a mindset that prioritizes writing code that is **clear, concise, and easy to understand**. In other words, the emphasis is on writing code that accurately reflects the your intentions rather than trying whatever and seeing if it sticks. Approaching a solution in code intentionally will inevitably be a lot more productive and easier to maintain and extend in the future. 

Incremental programming, on the other hand, involves **dividing the solution you are trying to create into small, manageable chunks** that can be developed and tested individually. This allows for a more flexible, iterative approach to software development. This means that changes can be made easily and quickly, without having to completely overhaul the entire solution when something crashes. 

As you may have seen from the last lab, handling large amounts of data in C is no small task. It requires attention to detail and a good understanding of the the code you are writing and what it does. As the projects in this and other programming-centric classes become more complex and involved, it is important to remember that **the best line of defense against buggy code is a good offense: intentional and incremental programming.**

### Trace debugging
Trace debugging is a technique used to identify the root cause of a problem in a program by logging the values of variables and other information at specific points in time. This trace data can provide insight into how your program is actually behaving.

One form of trace debugging is performing manual checks on data by adding `printf()` statements to a program. Printing out the value of a buggy variable every time it gets modified can help you track the changes and note where the algorithm goes wrong.

```c
void modify_string(char * in_str){
    // Implementation of function here
    //      ...     
}

...

printf("Original Str:\t%s\n", original_str);    // <--- Trace debug print statement (sees the original string value)

modify_string(original_str); 

printf("Modified Str:\t%s\n", original_str);    // <--- Trace debug print statement (sees the modified string value)

```

And that's really all there is to this method! You'll be surprised to see how effective the simple logging of variable values as you go can ensure a smoother development experience. By using trace debugging, you can quickly identify and fix bugs, improve the performance of your program, and improve the overall reliability of your software.

**In the lab files for this repository, go to the `trace-debug` folder. There you will find a library, an implementation, and a main file. Buggy functions have been included in the `math.c` file. Your job is to debug them using the trace debugging method and ensure that all of them work properly.**

### Using a Debugger
While trace debugging may seem like the most practical way to address small bugs or issues in your code, sometimes it is not enough. Have you every printed out the contents of a double or even triple-nested `for` loop to try and find out where your logic went wrong? If not: congratulations! Like all others who have, we can assure it is no fun, especially when the terminal window fills up with unnecessary print statements that makes the bug more difficult to find.

The simple solution to this is to use a debugger! A debugger is a program that controls the execution of a program, and allows us to pause it whenever we want and examine the values of variables and how they change during runtime. For this class we will be using the GDB debugger. To ensure it is installed on your Pi Z2W, run the following command:

```bash
sudo apt install gdb
```

According to their [homepage](https://www.sourceware.org/gdb/), "GDB, the GNU Project debugger, allows you to see what is going on `inside' another program while it executes -- or what another program was doing at the moment it crashed." This the default program we will be using to debug the code in this class. This program has several modes of operation, including a terminal and graphical interface. 

#### VSCode C/C++
More modern tools like VSCode have built-in extensions to interface with GDB and provide a more modern experience. To enable this on your Pi Z2W, follow the following steps in a **Remote - SSH** session that is connected to your Pi Z2W:

1. Click on the Extensions button on the left-side menu.

2. In the search bar, type "C/C++" and select the "C/C++" extension by Microsoft.

3. Click the Install button to install the C/C++ extension.

4. Make sure your Workspace root is at where all of your files live (i.e this lab's repo)

5. Open up the `main.c` file from one of your labs

6. Go to the `.vscode` folder and open file named `tasks.json`

7. Find the section of code that looks like the following

    ```json
                "args": [
                "-fdiagnostics-color=always",
                "-g",
                "${file}",
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}"
            ],
    ```

    and replace `${file}` with `*.c` and save the file.

8. Go to your `main.c` tab and click on the play button with bug in the upper right corner

9. If your debugger was configured properly, you should not see any errors and a new debugger view should show.


**For this section of the lab, copy some old code from either the _Image_ or _Data_ lab into the `gdb-debug` folder. Follow the corresponding questions on the README.md for this lab as you learn the following techniques of graphical debugging.**

Before you can start debuggin your code in VSCode, you need to make sure that it is running. Click on the play button with a little bug on it in the upper right corner. You should see a menu pop up in the middle top of your screen. These are the controls that will help you run through your program.

#### Breakpoints
A breakpoint is a point in the code where the debugger stops the execution of the program. Breakpoints can be set in VSCode by clicking next to the line number of the code that you want your debugger to pause on.

#### Step Over
Stepping over a function means that you will run a function and receive its outputs in one step. If you are certain that a function is working well or you do not want to step into system function definitions, use this option. This is done by clicking on the button with the arched arrow and circle.

#### Step In/Out
If you come across a function that you want to examine, put a breakpoint on where it is called. Then when you reach the paused line, click on the down arrow in the debug ribbon at the top of the screen. This will allow you to look at how the function is executing. To leave this function and continue the flow of the program, click on the up button.

**Answer the questions on the `README.md` and don't forget to include screenshots.**

### Analyzing Assembly

Not only can you build your project to analyze the source code, you can also use it to analyze the machine instructions that are getting passed to the processor. This is useful, especially in digital forensics and penetration testing. Not every executable you want to analyze was compiled with the `-g` option to let a debugger look at the source code.

Analyzing assembly in VSCode tends to be a little trickier and require you to use `gdb` in the terminal. You can get started by typing in your terminal

```bash
gdb bin_file_name
```

Once you are inside of the commandline version of `gdb`, you will see another shell that looks something like the following:

```
(gdb)> _
```

To view the assembly instructions of the file, type in `layout asm`.

Some helpful GDB commands to get you going:

| Command | Description |
| ------ | ----------- |
| `break` or `b` | Sets a breakpoint on a specific line |
| `print varname` or `p`| Prints out the value of the variable `varname` |
| `step` or `s` | Step through your code. |
| `stepi` | Step through the code instruction by instruction. |
| `continue` | Run to the next breakpoint |
| `run` | Run your loaded gdb code |

These are just a few of the commands, some helpful resources have been provided in the links at the bottom of the lab.

 **In this exercise, you are expected to apply your knowledge about debugging that you learned in the last section and apply that to an unfamiliar environment like ASM. Answer the corresponding questions on the `README.md` file to finish this section.**

## Submission

- Complete all the activities and answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.


## Explore More!
- [GDB Cheatsheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
- [GDB Debuggin Guide](https://sourceware.org/gdb/onlinedocs/gdb/index.html#SEC_Contents)