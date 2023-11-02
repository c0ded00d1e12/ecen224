---
title: Client
number: 9
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Learning Suite for the lab to accept the assignment.

## Objectives

- Interact with `struct`s
- Handle raw data in a buffer
- Send data over a network socket

## Overview
You have come very far in understanding how to control your computer! Up until this point, we have covered programming peripheral devices, handling inputs from a user, and many other skills that allow you to control your Pi Z2W to the fullest! In this we will take you from influencing processes on your own system to interacting with programs on other systems! 

In this lab you will be sending some of your saved photos

### Config Struct

#### IP Addresses and Ports
Before we can access a program on a different computer, we need to know where that computer lives. In order to know where that computer lives, we need to know that computer's address. For example, when you are on your web browser and you want to visit [https://byu.edu](https://byu.edu), the browser will use a special protocol to extract the **IP address** from the **domain name** that you provided in the URL bar.

If you want to find an IP address of a certain website (most popular ones have many), you can use `ping` and observe the output:

```
$ ping byu.edu

PING byu.edu (128.187.16.184) 56(84) bytes of data.
64 bytes from byu.com (128.187.16.184): icmp_seq=1 ttl=58 time=2.53 ms
64 bytes from email.byu.edu (128.187.16.184): icmp_seq=2 ttl=58 time=2.92 ms
64 bytes from email.byu.edu (128.187.16.184): icmp_seq=3 ttl=58 time=11.1 ms

```

Note that `128.187.16.184` is the IP address of the server that responded to our `ping`.

Now that we know the address of the computer that we want to talk to, we need to know what **port** is being used by the program we want to communicate with. 
A port is a special window that a program uses to communicate with other programs. 
For example, a web server that is hosting a website normally does this under port `80` or `443` (if you are using HTTPS instead of HTTP). Every time you use `ssh` on your computer, you are talking to the remote computer over port `22` by default.

When we connect to another computer that is *listening* on a specific port, we refer to the listening computer as the **server** and the computer that is trying to connect to the server as the **client**. 

#### Struct Data Members
In order to talk to a server, we need to know several things about it. For this lab, the `Config` `struct` in `client.h` contains the information you will need in order to connect to the server:

```c
typedef struct Config {
    char *port;
    char *host;
    uint8_t *payload;
    char *hw_id;
} Config;
```

| Data Member                                                                                            | Description                                                                                                                       |
| ------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| `port`                                                                                                 | The location of photo uploader program is running                                                                                 |
| `host`                                                                                                 | This is the hostname of the server we are trying to connect to                                                                    |
| `payload`                                                                                              | This is the data we want to send to the server. In this lab, that will be the image data.                                         |
| `hw_id`                                                                                                | This is your Learning Suite assigned homework ID for this class. In order to find your unique homework ID, go to Learning Suite > this course > Grades > And then click on the small link at the top that says `Show Course Homework ID` |

The location you will be connecting to to upload your photos in this lab will be:
- Host: netlab.et.byu.edu
- Port: 2225

### Network Socket
Now that we know where to go to talk to a different computer/server in our program, how do we go about doing that? The answer is quite simple and more surprising than you would think. Talking to a different computer in C is much like writing or reading data to a file. However, instead of writing to a file, we will be writing to a socket.

When we want to write to a file in C, we need to use the function `fopen()` to create or open the file that we want to read from or edit. In network programming, it is not this simple and actually requires a bit of investigating. However, for this lab, you will not be expected to create a network socket by yourself. The function `client_connect()` has been written for you to do this. However, just like a `fopen()` returns a `FILE` pointer so that you can keep track or your progress in reading or writing to the file, in this lab, `client_connect()` returns a file descriptor (with the data type of int) that lets your program keep track of which port your computer will use to talk to the remote computer.

### Sending Data
Just like in the I/O lab, you will notice that much of what you will be doing in this lab is using write functions to the socket file descriptor. Instead of using `fwrite()` you will be using a function (see the link in **Explore More**) called `send()`. Look at the tutorial below to see how the function behaves and you will notice it is very close to writing to a file. However, be careful. Since this is network programming, there is no guarantee that when you call `send()` that it will send all the data in the buffer you tried to send. You will be responsible for writing the logic to ensure that **all** of the data is sent correctly.

### Freeing Memory
Just like in any other file, directory, or memory operation that allocates a pointer or memory off of the stack, you will need to free that memory. If this is not done, unexpected behavior may occur on your system. So remember the following:

| Memory Allocation                                                                                                                      | Freeing Call |
| -------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| `malloc`                                                                                                                               | `free`       |
| `fopen`                                                                                                                                | `fclose`     |
| `opendir`                                                                                                                              | `closedir`   |
| `socket` (don't worry about calling this function in this lab, this is done for you already in the provided `client_connect` function) | `close`      |


## Requirements

In this lab you should accomplish the following:
- Copy your code from the previous lab into the cloned repository for this lab on your Pi Z2W.
- Assign the left button (or the up button in code) to send the selected image to the server at netlab.et.byu.edu:2225
    - Load the Config struct with the appropriate address data
    - Start the client connection
    - Load the appropriate image data into the struct
    - Implement the sending function
    - Close the connection

## Submission

### Compilation
Since a large portion of this lab's grade depends on me successfully compiling your code, the following points must be adhered to to ensure consistency in the grading process. Any deviation in this will result in points off your grade:

- The code in this lab will be compiled at the root of this lab repository (i.e. `client-<your-github-username>`). It is your responsibility to ensure that `gcc` will work from this directory.
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
- [`memcpy()` in C](https://www.tutorialspoint.com/c_standard_library/c_function_memcpy.htm)
- [`send()` in C](https://man7.org/linux/man-pages/man2/send.2.html)
- [Ultimate Guide to Network Programming in C](https://beej.us/guide/bgnet/html/)
