---
layout: homework
title: I/O
icon: fa-duotone fa-server
number: 5
problems:
---

1. (3 points) Give an example of a human “protocol” used in the real world. Answer the following questions about the protocol.
    
    (a) What is the purpose of the protocol?
    
    (b) What are the rules of the protocol?
    
    (c) What are the consequences of violating the protocol?

2. (4 points) Convert the following hex addresses into dotted-decimal addresses:
    
    (a) `0x0DF9CD0D`
    
    (b) `0x8EFA45EE`
    
    (c) `0x80BB10B8`
    
    (d) `0x0A207376`

3. (1 point) What is the IP address for `lundrigan.byu.edu`? Hint: you can figure out the answer by using a command line tool.

4. (1 point) What is a ephemeral port compared to a well-known port?

5. (1 point) Download [this code]({% link assets/io-p5.c %}). The program has a bug where it exits out before the ”Hello world!” message gets printed out. Fix the bug. Name your file `p5.c`.

6. (5 points) Write a program that reads from [this binary file]({% link assets/secret.txt %}). The file contains a secret message that you must find. To find the message, you must read **4 bytes** starting at **byte 11** (remember to use zero index when counting bytes). This will reveal the second location to read from. Then, you must read from the second location (still reading 4 bytes) to reveal the third location, and so on. Repeat this process 5 times (for a total of 6 seeks and 5 reads). The last location will contain the message length encoded as 4 bytes, followed by the ASCII message itself. Your program should print out the secret message. 
<div class="alert alert-secondary" role="alert">
Hint: you will need to use <code>fseek</code> to move the file pointer to the correct location. All 4 byte values are stored in little endian format. Name your program file <code>p6.c</code>.
</div>