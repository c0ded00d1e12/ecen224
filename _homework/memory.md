---
layout: homework
title: Memory
icon: fa-duotone fa-memory
number: 4
problems:

---

1. (1 point) Write a program that provides good temporal locality. Name your program `p1.c`.
2. (1 point) Write a program that provides good spatial locality. Name your program `p2.c`.
3. (2 points) Write a small program that demonstrates how much faster reading from memory is compared to reading from disk. Your program should read from a file with a list of numbers and sum the numbers together. Read the file once to load it into memory and sum all the numbers, then read the file again summing the numbers directly from the file. Time both operations and print out the results. Here is a [template you can use as a starting point]({% link /assets/p3.c %}) and you can use [this list of numbers]({% link /assets/p3_numbers.txt %}). Name your program `p3.c`.
4. (2 points) Download the [following program]({% link /assets/p4.c %}) and measure how much time each function (`sum_array_rows` and `sum_array_cols`) takes to run (see previous question’s template to see how to set up a timer). Which function ran faster and why?
5. (1 point) Watch [this video on virtual memory](https://www.youtube.com/watch?v=5lFnKYCZT5o) and write 3 things you learned from the video. If you did not learn anything from the video, then suggest a video on virtual memory or the caching hierarchy where you did learn something.