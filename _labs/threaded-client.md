---
title: Threaded Client
number: 10
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Slack channel for the lab to accept the assignment.

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

This object is used inside a range of different functions found inside the `pthread.h` library. WThe most important one of these functions for this lab is `pthread_create()` which allows us to spawn a new thread and assign the function that it will run. Consider the simple threading program below:

```c
#include <stdio.h>
#include <unistd.h>   // Library that includes sleep()
#include <pthread.h>  // Library that includes pthreading types and functions

void * print_msg()
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
3. The name of the function that will be run inside of the thread. You'll notice that we only provide the **name of the function and _we are not calling the function_** (`print_msg` instead of `print_msg()`).
4. This argument is meant for the arguments that will be provided for the function to be run in the thread. Notice that for this example it is `NULL` since our function doesn't require any special arguments. More on how to pass arguments into a thread is found in the following section.

You'll notice that both our `main()` function and our `print_msg()` function have `while(1)` loops that will run indefinitely. Were we not using threading our program would always be stuck inside the loop inside of `main`, however, since we spawned a thread with `pthread_create()` before that loop was reached, the thread will its function alongside of `main` and we can expect output like the following:

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
A `void *` is the generic pointer in C. This means that anything can be cast to or from a `void *` object. This datatype is very useful when using threading functions because it allows us to pass in virtually anything in. You can see this manifest in the datatypes that `pthread_create()` expects for its arguments. This also accounts for why our `print_msg()` function in the previous example program's return type had to be a `void *`. The datatype that is expected to pass in arguments to the function we are running in a thread is also a `void *`. So what would that look like?

#### Example
Consider the following program:
```c
#include <stdio.h>
#include <unistd.h>   // Library that includes sleep()
#include <pthread.h>  // Library that includes pthreading types and functions

void * print_num(void *arg)
{
    while(1)
    {
        // Notice that we have to cast the void * back to an int * and then we use the * to get the value inside
        printf("The number is:\t%d\n", *(int *) arg);
        sleep(2);     // Sleeps for 2 seconds
    }
}

int main()
{
    int * i = (int *)malloc(sizeof(int));    // Create an int pointer and give it enough space to hold an int.
    *i = 0;                                  // Set the value inside the pointer to 0

    pthread_t my_thread;

    // Notice that we have to cast i to a void *
    pthread_create(&my_thread, NULL, print_msg, (void *) i); 

    while(1)
    {
        *i = (*i) + 1;                      // Increment the value inside of i
        printf("I'm in main!\n");
        sleep(1);
    }

    return 0;
}
```

Let's take a closer look at our `pthread_create()` function and the handling of our `i` pointer. You'll notice some things about `i`:
- It is a pointer that needed to be `malloc`d.
- To set a value to it we needed to refer to the pointer's contents `*i`
- When we passed it into `pthread_create()`, we needed to cast it to a `void *`.

With `i` in its proper form, we can use it inside of `pthread_create()` without any issues, but how do we actually handle that inside of the function of our thread? Let's take a look at our `print_num()` function:
- The argument now is a `void *`
- To use `arg` we need to do two things:

    1. Cast `arg` back into the type that we expect (in this case an `int *`)
    2. Deference it with a * to get the value inside (the `*` infront of the cast statement)

### Return Values from Threads
To get a return value from a thread in C, you would need to use the `pthread_join()` function. For the purposes of this lab, we will not be using `pthread_join()`, but you can read more about it in the **Explore More!** section. `pthread_join()` is **NOT** recommended for this lab.

### Technical Debt
Technical debt is the idea that when you code something for the first time, it is normally not the most polished code. When you need to go back and improve the functionality of your code, there will need to be some refactoring done. 

You may have noticed at this point that threading is very function heavy. This means that to use it in your doorbell code, you will need to have nice functions that group code together for certain tasks. If you have not been using functions up to this point, you are likely in some technical debt. You will need to encapsulate some functionality into functions as described in the **Requirements** sections below.

## Requirements
In this lab you should accomplish the following:
- You will use the code from your previous lab. However, a new `main.c` has been provided in this lab as a boilerplate for you to paste your old code into. Several new functions have been added that you will need to fill out.
- Refactor your code by putting all code that sends image data to the server into the `send_data` boilerplate function
- Put a 10 second delay at the beginning of the `send_data` function. This is to make the effects of threading more obvious
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

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.

- **MAKE SURE YOUR CODE FOLLOWS THE CODING STANDARD!** More info on how to set that up is available on the Coding Standard page. 


## Explore More!
- [`sleep()` man page](https://man7.org/linux/man-pages/man3/sleep.3.html)
- [`pthread_create()` man page](https://man7.org/linux/man-pages/man3/pthread_create.3.html)
- [`pthread_join()` man page](https://man7.org/linux/man-pages/man3/pthread_join.3.html)
- [pthreads in C](https://www.geeksforgeeks.org/multithreading-in-c/#)