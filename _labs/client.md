---
title: Client
number: 9
layout: lab
---

## Objectives

- Interact with `struct`s
- Handle raw data in a buffer
- Send data over a network socket

## Getting Started

Use the GitHub Classroom link posted in the Learning Suite for the lab to accept the assignment. Next, ssh into your Raspberry Pi using VSCode and clone the repository in your home directory. **This lab should be done in VSCode on your Raspberry Pi. Make sure the lab is top level folder of your VSCode editor.**

## Overview

You have come very far in understanding how to control your computer! Up until this point, we have covered programming peripheral devices, handling inputs from a user, and many other skills that allow you to control your Pi Z2W to the fullest! In this lab, we will take you from influencing processes on your own system to interacting with programs on other systems! In this lab you will gain practice with network programming by sending some of your saved photos over a network to a server.

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
As mentioned previously, in order to talk to a server, we need to know several things about it. For this lab, the `Config` `struct` in `client.h` contains the information you will need in order to connect to the server:

```c
typedef struct Config {
    char *port;
    char *host;
    uint8_t *payload;
    char *hw_id;
} Config;
```

| Data Member | Description                                                                                                                                                                                                                            |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `port`      | The port number of the application you are trying to connect to.                                                                                                                                                                       |
| `host`      | This is the hostname of the server you are trying to connect to.                                                                                                                                                                       |
| `payload`   | This is the data you want to send to the server. In this lab, that will be the image data.                                                                                                                                             |
| `hw_id`     | This is your Learning Suite assigned homework ID for this class. In order to find your unique homework ID, go to Learning Suite > this course > Grades and then click on the small link at the top that says "Show Course Homework ID" |

The location you will be connecting to to upload your photos in this lab will be:
- Host: ecen224.byu.edu
- Port: 2240

### Network Socket
Now that we know the server name and port that we want to connect to, how do we go about doing that? The answer is quite simple and more surprising than you would think. Talking to a different computer in C is much like writing or reading data to a file. However, instead of writing to a file, we will be writing to a **socket**.

When we want to write to a file in C, we need to use the `fopen()` function to open the file. In network programming, it is a bit more complicated. However, for this lab, you will not be expected to create a network socket by yourself. The function `client_connect()`, which connects to a server port and opens a socket, has been written for you. Similar to how `fopen()` returns a `FILE` pointer that you use to interact with a file, `client_connect()` returns a file descriptor (with the data type of `int`) that lets your program keep track of which port your computer will use to talk to the remote computer.

### Sending Data
While in previous labs you used `write()` to write to a file, for network programming, we use `send()` to write to a socket (see the link in **Explore More** for more details about this function). 
Look at the tutorial below to see how the function behaves and you will notice it is very close to writing to a file. However, be careful. Since this is network programming, there is no guarantee that when you call `send()` that it will send all the data in the buffer you tried to send. You will be responsible for writing the logic to ensure that **all** of the data is sent correctly by implementing a function called `client_send_image` in `client.c`.

The standard `send` function will return how much of the data actually got sent. If the amount of data you were expecting to send is not the same as what `send` returned, that means not all of the data got sent. For example, if I am sending data that is 100 bytes long and I call `send` and it only returns 50, that means only the first 50 bytes got sent. I need to call `send` again, passing the rest of the data. You will need to keep calling send until the total bytes sent is equal to 100. Here is some pseudo-code to help:

```
int socket = ...
uint8_t *data = ...
int data_length = ...
int total_sent = 0
int num_sent = 0

while total_sent < data_length:
    num_sent = send(socket, data + total_sent, data_length - total_sent, 0)

    if num_sent == 0:
        print("Error while sending data")
        break

    total_sent += num_sent
```

### Deallocating Resources
When calling functions that create or allocate system resources, you need to remember to free those resources when you are done with them. 
If this is not done, unexpected behavior may occur on your system. So remember the following:

| Resource Allocation                                                                                                                    | Freeing Call |
| -------------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| `malloc`                                                                                                                               | `free`       |
| `fopen`                                                                                                                                | `fclose`     |
| `opendir`                                                                                                                              | `closedir`   |
| `socket` (don't worry about calling this function in this lab, this is done for you already in the provided `client_connect` function) | `close`      |


## Requirements

- Copy your code from the previous lab into the cloned repository for this lab on your Pi Z2W.

- Same as last lab, when you press the center button, you should take a picture and show the picture, allowing the user to apply different filters. When you press the center button again, instead of exiting the picture and going to the menu right away, first connect to the server and send the picture. Once you have sent the picture, show the menu. Specifically, when the center button gets pressed while showing the picture you should do the following:
    - Load the `Config struct` with the appropriate address data.

    - Load the appropriate image data into the `Config struct`. Use the buffer filled by the `camera_capture_data` function (the data with the BMP header and BMP data) as the payload.
    
    - Start the client connection using `client_connect()`.
    
    - Call the `client_send_image` function to send the data.
    
    - Close the connection using `client_close()`.

    - Show the menu.

- Implement `client_close()` function in `client.c`.

- Implement the `client_send_image()` function in `client.c`. This function's job is to make sure all of the data is successfully sent to the server.
    

## Submission

- Answer the questions in the `README.md`.

- To pass off to a TA, demonstrate your doorbell running your program that fulfills all of the requirements outlined above. You must also show the TAs your implementation of the `client_send_image` function and where you close the socket.

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Committing and Pushing Files** section.


## Explore More!

- [`memcpy()` in C](https://www.tutorialspoint.com/c_standard_library/c_function_memcpy.htm)

- [`send()` in C](https://man7.org/linux/man-pages/man2/send.2.html)

- [Ultimate Guide to Network Programming in C](https://beej.us/guide/bgnet/html/)
