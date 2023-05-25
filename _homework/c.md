---
layout: homework
title: C
icon: fa-duotone fa-brackets-curly
number: 2
layout: homework
---

1. (1 point) What does the `#include` preprocessor directive do?

2. (1 point) What is the value of `sizeof(char)`? `sizeof(int)`? `sizeof(int32_t)`?

3. (1 point) What function is the starting point for all C programs?

4. (1 point) What are the two kinds of comments in C?

5. (1 point) What does the following code print?

    ```c
    #include <stdio.h>

    int x = 1;

    void print_number() { printf("%d\n", x); }

    int main() {
        int x = 2;
        printf("%d\n", x);

        {
            int x = 3;
            printf("%d\n", x);
        }

        print_number();
    }
    ```

<!--The start="" syntax is Jekyll I think. -->
<!-- This is fixing an issue where the numbering would reset to '1.' after a code block. Source: https://stackoverflow.com/a/41917631 -->

{:start="6"}
6. (1 point) What does the following code print?

    ```c
    #include <stdio.h>

    #define PLUS1 x + 1

    int main() {
        int x = 10;
        int y = 5 * PLUS1;
        printf("%d\n", y);
    }
    ```

{:start="7"}
7. (1 point) What is the name of the mystery function shown below? Hint: it is a standard library function.

    ```c
    int mystery(char s[]) {
        int i = 0;
        while (s[i] != '\0') {
            ++i;
        }
        return i;
    }
    ```

{:start="8"}
8. (1 point) What does the code below print out?

    ```c
    #include <stdio.h>

    int main() {
        enum {hello=3, goodbye} myEnum = goodbye;
        printf("%d\n", myEnum);
    }
    ```

{:start="9"}
9. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        printf("%d\n", '1');
    }
    ```

{:start="10"}
10. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        printf("%d\n", "13");
    }
    ```

{:start="11"}
11. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        printf("%.*s", 5, "hello there\n");
    }
    ```

{:start="12"}
12. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        char array[20];
        sprintf(array, "%s", "hello there!");
    }
    ```

{:start="13"}
13. (1 point) What does the following program print when executed and when you type 2 2 2 and press enter (or carriage return)?

    ```c
    #include <stdio.h>

    int main() {
        int month, day, year;
        printf("%d\n", scanf("%d %d %d", &month, &day, &year));
    }
    ```

{:start="14"}
14. (1 point) What does the following program print when executed? Why?

    ```c
    #include <stdio.h>
    #include <string.h>
    #define LENGTH 100
    int main() {
        char string1[LENGTH] = "hello ";
        char string2[LENGTH] = "there";
        strcpy(string1, string2);
        printf("%s\n", string1);
    }
    ```

{:start="15"}
15. (1 point) What does the following program print when executed? Why?

    ```c
    #include <stdio.h>
    #include <string.h>

    #define LENGTH 100

    int main() {
        char string1[LENGTH] = "hello ";
        char string2[LENGTH] = "there";
        strcat(string1, string2);
        printf("%ld\n", strlen(string1));
    }
    ```

{:start="16"}
16. (1 point) What does the program below print out?

    ```c
    #include <stdio.h>

    int main() {
        int i = 9;
        int j = ((0 > 1) && (i=14));
        printf("%d\n", i);
    }
    ```

{:start="17"}
17. (1 point) What does the program below print out?

    ```c
    #include <stdio.h>

    int main() {
        int i = 9;
        int j = ((0 > 1) || (i=14));
        printf("%d\n", i);
    }
    ```

{:start="18"}
18. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        int i = 0 < 1;
        printf("%d\n", i);
    }
    ```

{:start="19"}
19. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>
    #include <math.h>

    int main() {
        int n = 16;
        printf("%d\n", sqrt(n));
    }
    ```

{:start="20"}
20. (1 point) What does the following program print out?

    ```c
    #include <stdio.h>

    int main() {
        int j = 4;
        printf("%d\n", j++);
        printf("%d\n", ++j);
    }
    ```

{:start="21"}
21. (1 point) What is the value printed out by the program shown below?

    ```c
    #include <stdio.h>

    int main() {
        printf("%d\n", 0xf0 | 0xf == 0xff);
    }
    ```

{:start="22"}
22. (1 point) What is the value printed out by the program shown below?

    ```c
    #include <stdio.h>

    int main() {
        printf("%d\n", (0xf0 | 0xf) == 0xff);
    }
    ```

{:start="23"}
23. (1 point) If you decare an array like this: i`nt values[10]={3};`, what is the value of `values[5]`?

{:start="24"}
24. (1 point) If you have an array `uint32_t vals[10]`, what is the value of `sizeof(vals)`?

{:start="25"}
25. (1 point) If you declare a string (char array) like this: `char str[10] = "hi";`, what is the size of the array (in bytes)? What is returned by `strlen(str)`?

{:start="26"}
26. (1 point) Are these two if statements equivalent? Why or why not?

    ```c
    if (x) {
        ...
    }
    if (x == 1) {
        ...
    }
    ```

{:start="27"}
27. (1 point) Are these two if statements equivalent? Why or why not?

    ```c
    if (x) {
        ...
    }
    if (x != 0) {
        ...
    }
    ```

{:start="28"}
28. (1 point) How many times will this program print out the statement “did nothing”?

    ```c
    #include <stdio.h>

    int main() {
        int i = 10, j;
        if (i >= 0) {
            for (j = 0; j < i; j++) {
                if (j == 10) {
                    printf("%d\n", j);
                    return i;
                } else {
                    printf("did nothing.\n");
                }
            }
        }
    }
    ```

{:start="29"}
29. (1 point) What will the following program will print out?

    ```c
    #include <stdio.h>

    int main() {
        int x = 10;
        if (x > 0)
            printf("1\n");
        else if (x > 1)
            printf("2\n");
        else if (x > 2)
            printf("3\n");
        else
            printf("4\n");
    }
    ```

{:start="30"}
30. (1 point) What is the last thing this program will print?

    ```c
    #include <stdio.h>

    int main() {
        int x = 0;
        for (;;) {
            printf("%d\n", x++);
            if (x > 2)
                break;
        }
    }
    ```

{:start="31"}
31. (1 point) How many times will this program print “hi!”?

    ```c
    #include <stdio.h>

    int main() {
        int i = 0;
        do
            printf("hi!\n");
        while (i);
    }
    ```

{:start="32"}
32. (1 point) How many times will this program print “hi!”?

    ```c
    #include <stdio.h>
    int main() {
        while (1) {
            printf("hi!\n");
            break;
        }
    }
    ```

{:start="33"}
33. (1 point) How many times will this program print “hi!”?

    ```c
    #include <stdio.h>

    int main() {
        while (1) {
            printf("hi!\n");
            continue;
        }
    }
    ```

{:start="34"}
34. (1 point) How many times will this program print “hi!”?

    ```c
    #include <stdio.h>

    int main() {
        int i;
        for (i = 0; i < 10; i++) {
            if (i % 2)
                continue;
            printf("hi!\n");
        }
    }
    ```

{:start="35"}
35. (1 point) How many times will this program print “hi!”?

    ```c
    #include <stdio.h>

    int main() {
        int i;
        for (i = 0; i < 10; i++) {
            if (i % 2)
                break;
            printf("hi!\n");
        }
    }
    ```

{:start="36"}
36. (1 point) What value with the program print?

    ```c
    #include <stdio.h>

    int main() {
        int x=4;
        int *y = &x;
        y++;
        printf("%d\n", *y);
    }
    ```

{:start="37"}
37. (1 point) What value with the program print?

    ```c
    #include <stdio.h>

    int main() {
        int x = 4;
        int y = &x;
        y++;
        printf("%d\n", y++);
    }
    ```

{:start="38"}
38. (1 point) What value will the program print?

    ```c
    #include <stdio.h>

    int main() {
        int x = 4;
        int* y = 5;
        y++;
        y++;
        printf("%d\n", y++);
    }
    ```

{:start="39"}
39. (1 point) What value will the program print?

    ```c
    #include <stdio.h>

    int main() {
        int x = 4;
        int* y = &x;
        (*y)++;
        printf("%d\n", y);
    }
    ```

{:start="40"}
40. (1 point) What value will the program print?

    ```c
    #include <stdio.h>

    int main() {
        int x = 4;
        int* y = &x;
        (*y)++;
        printf("%d\n", *y++);
    }
    ```

{:start="41"}
41. (3 points) Write a C program that given a 32-bit number that represents an RGB value, prints out the red, green, and blue values.

    ```c
    #include <stdio.h>

    int main() {
        // Your code should work for any value of rgb.
        uint32_t rgb = 0x60B3BE;

        // You need to fill in these values using the code below
        uint8_t red;
        uint8_t green;
        uint8_t blue;

        // Put your code here...



        // Print out the result
        printf("red: %d\n", red);
        printf("green: %d\n", green);
        printf("blue: %d\n", blue);
    }
    ```

{:start="42"}
42. (5 points) Write a homework question that you think would be good for future students to answer to help them learn more about what has been covered in lecture so far.