---
title: Threaded Client
number: 10
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Learning Suite for the lab to accept the assignment.

## Objectives

- Deal with technical debt
- Learn to multitask in C
- Create a POSIX thread with arguments

## Overview

One of the last fundamentals to know about programming in general is how to make your program do multiple things at once. Until this point, we have written **single-threaded programs**. This means that our programs have only followed a single path of execution while it runs (i.e the program can only focus on one task at a time). 

However, many of the problems that we solve in the real-world are much more complex and may require us to interact with many facets of the problem simultaneously. In the lab for this class, creating a useful smart doorbell is definitely one of those multifacted problems. Consider the following:
- How can I back-up my files to the server while viewing a photo?
- How can I actively be monitoring the status of my back-up while also drawing to my screen in a loop?

While considering the previous questions, you may have noticed that with your current skillset, these problems seem difficult to solve without a complex algorithm or multiple programs running at once. By using threads, we can sidestep a lot of this headache by grouping different tasks/functions into distinct threads and call them from our main thread. 

### Creating a Thread
Threads in Linux programming are known as [POSIX](https://en.wikipedia.org/wiki/POSIX) threads (or pthreads for short). `pthread_t` is the data type used to uniquely identify a thread:

```c
#include <pthread.h>

pthread_t my_thread;
```

This object is used inside a range of different functions found inside the `pthread.h` library. The most important function for this lab is `pthread_create()`, which allows us to spawn a new thread and provide the function that it will run. Consider the simple threading program below:

```c
#include <stdio.h>
#include <unistd.h>   // Library that includes sleep()
#include <pthread.h>  // Library that includes pthreading types and functions

void * print_msg(void *unused)
{
    while(1)
    {
        printf("I'm in a thread!\n");
        sleep(2);     // Sleeps for 2 seconds
    }
}

int main()
{
    pthread_t my_thread;
    pthread_create(&my_thread, NULL, print_msg, NULL);

    while(1)
    {
        printf("I'm in main!\n");
        sleep(1);
    }

    return 0;
}
```

To compile using the `pthread.h` library, you will need to add `-lpthread` to your normal `gcc` compile command.

Let's take a closer look at what is going on in the `pthread_create()` function. The arguments that are expected in the function are as follows:
1. The address of your thread identifier. This is how your program will know how to identify your thread in the program.
2. This argument expects a special `pthread_attr_t` struct pointer. Since we are covering the basics of threading in this class, this field is ignored by putting a `NULL` in its place.
3. A pointer to the function we are calling.  Function pointers can be provided by giving the name of the function.  Make sure you only provide the name, and don't *call* the function (eg. `print_msg` instead of `print_msg()`).  If you like, you can put a `&` in front of the function name to make it more obvious it's a function pointer (eg. `&print_msg`), but this is not required by the compiler.
4. A pointer you provide to this argument will be passed as an argument to the function you are running in the new thread.  This is a great way to provide information to the new thread.  Notice that for this example it is `NULL` since our function doesn't require any special arguments.  The following section has more information about how to pass arguments into a thread.

You'll notice that both our `main()` function and our `print_msg()` function have `while(1)` loops that will run indefinitely. Because threading allows us to run different functions simultaneously, we will see output that looks something like this:

```
I'm in a thread!
I'm in main!
I'm in main!
I'm in a thread!
I'm in main!
I'm in main!
I'm in a thread!
I'm in main!
I'm in main!
I'm in a thread!
I'm in main!
I'm in main!
...
```

### Passing in Arguments to a Thread
While the previous example may have been interesting in the sense that we've learned to use threads, it is pretty lackluster in the sense that we can't get any information into or out of the thread. To do this, we will need to understand working with `void *` and allocating memory.

#### void *: The Generic Pointer
A `void *` is the generic pointer in C. It is used to store a memory address, but does not indicate the type of data stored at the address.  This means that any type of pointer can be cast to or from a `void *` object. This datatype is very useful when using threading functions because it allows us to pass in the address of *any* type of data to the function we are spawning.  The function also *returns* a `void *` data type, allowing it to pass back a pointer to any type of data.  This accounts for why our `print_msg()` function in the previous example program's return type was a `void *`. 
<!-- The datatype that is expected to pass in arguments to the function we are running in a thread is also a `void *`. So what would that look like? -->

#### Example
Consider the following program:
```c
#include <stdio.h>
#include <unistd.h>  // Library that includes sleep()
#include <stdlib.h>  // Library that includes malloc()
#include <pthread.h> // Library that includes pthreading types and functions

void * print_num(void *arg)
{
    while(1)
    {
        // Notice that we have to cast the void * back to an int * and then we use the * to get the value inside
        printf("The number is:\t%d\n", *((int *) arg));
        sleep(2);     // Sleeps for 2 seconds
    }
}

int main()
{
    int * i = (int *)malloc(sizeof(int));    // Create an int pointer and give it enough space to hold an int.
    *i = 0;                                  // Set the value inside the pointer to 0

    pthread_t my_thread;

    // Notice that we have to cast i to a void *
    pthread_create(&my_thread, NULL, print_num, (void *) i); 

    while(1)
    {
        *i = (*i) + 1;                      // Increment the value inside of i
        printf("I'm in main!\n");
        sleep(1);
    }

    return 0;
}
```

Let's take a closer look at this code example.  The `pthread_create()` function is spawning a new thread to run the `print_num` function.  We want to pass an integer to this function.  Since we always use a `void *` to pass data to a function run by `pthread_create()`, we need to allocate memory for an integer and provide it's address as the last argument to `pthread_create()`.

You'll notice some things about how we've done this:
- We have allocated the space for the integer using `malloc`. While we could have simply declared an integer (`int i;`), this would create the integer on the stack.  In general, it's bad practice to pass addresses on the stack to other threads as they may continue to execute after stack variable goes out of scope.  Another alternative to `malloc` is to declare the integer as a global variable.
- To set the value of the integer to zero, we needed to refer to the pointer's contents: `*i = 0;`
- When we passed it into `pthread_create()`, we needed to cast it from a `int *` to a `void *`.

Now that we have provided the address of our integer to `pthread_create()`, let's take a look at how it is received by the `print_num()` function:
- The address is provided as an argument to the function with type `void *`.
- To use `arg` we need to do two things:

    1. Cast `arg` back into the type that we expect (in this case an `int *`).
    2. Deference it with a `*` to get the integer value pointed to by this address (the `*` in front of the cast statement).

### Return Values from Threads
To get a return value from a thread in C, you would need to use the `pthread_join()` function. For the purposes of this lab, we will not be using `pthread_join()`, but you can read more about it in the **Explore More!** section. `pthread_join()` is **NOT** recommended for this lab.

### Technical Debt
Technical debt is the idea that when you code something for the first time, it is normally not the most polished code. When you need to go back and improve the functionality of your code, there will need to be some refactoring done. 

You may have noticed at this point that threading is very function heavy. This means that to use it in your doorbell code, you will need to have nice functions that group code together for certain tasks. If you have not been using functions up to this point, you are likely in some technical debt. You will need to encapsulate some functionality into functions as described in the **Requirements** sections below.

## Requirements
In this lab you should accomplish the following:
- You will use the code from your previous lab. However, a new `main.c` has been provided in this lab as a boilerplate for you to paste your old code into. Several new functions have been added that you will need to fill out.
- Refactor your code by putting all code that sends image data to the server into the `send_image` boilerplate function.
- Put a 10 second delay at the beginning of the `send_image` function. This is to make the effects of threading more obvious.
- When the center button is pressed, take a picture and show it for 1 second and save the data to a new file (just like the previous lab with the 5 doorbell files)
- When the left button is pressed, send the data of the selected image inside the main thread by calling the `send_data` function
- When the right button is presesed, send the data of the selected image in a thread.
- Create a status bar the size of your highlight bar at the bottom of the screen with a blue background:

    - When your image is being sent in a thread, the text of the bar should say "Sending..." with the bar as a blue background and the text being white
    - When your image is sent successfully (i.e. the thread reached the end successfully), change the color of the status bar to green and in black text draw "Sent!"

        - This should should stay green with the sent message for 5 seconds and then timeout after 5 seconds and then turn back to blue with no text.
        - This requires the use of another thread, the `sent_timeout()` boilerplate function is provided.


## Hints
_coming soon :)_

## Submission

### Compilation
Since a large portion of this lab's grade depends on me successfully compiling your code, the following points must be adhered to to ensure consistency in the grading process. Any deviation in this will result in points off your grade:

- The code in this lab will be compiled at the root of this lab repository (i.e. `threaded-client-<your-github-username>`). It is your responsibility to ensure that `gcc` will work from this directory.
- Your binary must output to a folder called `bin`. This folder will be marked to be ignored by `git`, meaning that I will not receive your final compiled binary to test, but rather your code which must compile successfully on my Pi Z2W.

### Gitignore
In this lab you are expected to ignore the following:

- `.vscode` folders
- the `bin` folder where your binary is generated

### Normal Stuff
- Complete all of the requirements.

- Answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Committing and Pushing Files** and **Tagging Submissions** section.

- **MAKE SURE YOUR CODE FOLLOWS THE CODING STANDARD!** More info on how to set that up is available on the Coding Standard page. 


## Explore More!
- [`sleep()` man page](https://man7.org/linux/man-pages/man3/sleep.3.html)
- [`pthread_create()` man page](https://man7.org/linux/man-pages/man3/pthread_create.3.html)
- [`pthread_join()` man page](https://man7.org/linux/man-pages/man3/pthread_join.3.html)
- [pthreads in C](https://www.geeksforgeeks.org/multithreading-in-c/#)
