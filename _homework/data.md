---
layout: homework
title: Data
icon: fa-duotone fa-binary
number: 1

---

1. Perform the following number conversions:
    
    (a) (1 point) `0x42A0FD` to binary
    
    (b) (1 point) `0b1010111001101001` to hexadecimal
    
    (c) (1 point) `81` to hexadecimal

2. Without converting the numbers to decimal or binary, solve the following problems. Write the answers in hex.

    (a) (1 point) `0x935a + 0x8`

    (b) (1 point) `0x935a - 0x60`

    (c) (1 point) `0x935a + 64`

    (d) (1 point) `0x93ff - 0x935a`

3. For the following scenarios, pick which is the best data type to use, `short`, `unsigned short`, `int`, `unsigned int`, or `float`. Explain why you picked that type.

    (a) (1 point) A variable that keeps track of how many visitors enter an amusement park.
    
    (b) (1 point) A variable that records the minimum daily temperature for Provo for a given month in Celsius.

    (c) (1 point) A variable that counts the number of people on earth to the nearest thousands

4. (1 point) Write the decimal number 54 in binary as a `short` data type in both little endian notation and big endian notation.

5. (1 point) Write the decimal number 54 in binary as a `char` data type in both little endian notation and big endian notation.

6. Apply the following bitwise operations on the following numbers. Write the numbers in binary format.

    (a) (1 point) `0b01101100 & 0b11110011`

    (b) (1 point) `0b01101100 | 0b11110011`

    (c) (1 point) `0b01101100 ^ 0b11110011`

    (d) (1 point) `∼0b01101100`

    (e) (1 point) `0x41 & 0xF3`

7. Apply the following shift operations to the following numbers. Write the numbers in hex format.

    (a) (1 point) `0x6C << 3`

    (b) (1 point) `0x6C >> 3`

8. Apply the following logic operators on the following numbers. Write the number in decimal format.

    (a) (1 point) `01101100 && 11110011`

    (b) (1 point) `01101100 || 11110011`

    (c) (1 point) `!01101100`

9. (1 point) What is the hexadecimal representation of the string “hello”?

10. Write the 8-bit twos complement representation in binary of the following numbers.

    (a) (1 point) `86`

    (b) (1 point) `-86`

    (c) (1 point) `-2`

11. (1 point) What does the following C program print out?
    ```c
    unsigned short x = 0x3039;
    x = x + 0xF000;
    x = x & (0xFF00 >> 8);
    x = x + (x && x);

    printf("x = 0x%x\n", x);
    ```

12. (1 point) Write the floating point number representation for 6,841,721.

13. (1 point) Write the decimal number for the following floating point representation: `1100 0011 0101 1100 1100 0010 1110 1010`.

14. (2 points) In the following code, what value would you set `x` equal to so that the printf statement printed “224”?
    ```c
    int x;
    printf("%s\n", (char *)&x); // Print x as if it is an array of characters
    ```

15. (5 points) Write a homework question that you think would be good for future students to answer to help them learn more about what has been covered in lecture so far.