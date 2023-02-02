---
title: Image
number: 4
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Slack channel for the lab to accept the assignment.

## Objectives

- Gain experience with manipulating bytes in C by modifying image files. 
- Learn the structure of a multi-file C program (.h and .c files)
- Get more practice with compilation of a program by using `gcc`

## Overview

<figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/image/original.bmp %}" alt="Units of the course.">
  <figcaption style="text-align: center;">Original bitmap image that you will be editing in the lab.</figcaption>
</figure>

In this lab we will be exploring the utility of data manipulation in a practical application by editing an image in C. **This lab will be programming heavy** and a little more involved than previous labs. **Make sure you allow yourself enough time to complete this lab.**

### Bitmap Struct
Unlike other programming languages that you may be familiar with, the C programming language is not an object oriented programming language. This means that there are no `class` objects that allow you to associate groups of data together.

To accomplish this, C uses a the `struct` object, which is actually a predecessor to the `class` object we see in most programs. Below is the `struct` included in the `image.h` library in the code for this lab:

```c
typedef struct Bitmap
{
    FILE * img;
    uint8_t file_header[BMP_FILE_HEADER_SIZE];  // 14 bytes
    uint8_t * dib_header;                       // Variable
    uint8_t * pxl_data;                         // Pixel data for image
    uint8_t * pxl_data_cpy;                     // Copy of pixel data
    uint8_t pxl_data_offset;                    // Location of pxl data in img
    uint32_t img_width;                         // Image width
    uint32_t img_height;                        // Image height
    uint32_t file_size;                         // Size of the file
    uint32_t pxl_data_size;                     // Size of pixel data array
} Bitmap;
```

Much like a `class`, a `struct` is a collection of different variable values all associated with the same process. In the `Bitmap struct` we see many properties associated with the file, including:

- `pxl_data`: This is a one dimensional list of `uint8_t` values that represent pixel values in the image.
- `pxl_data_cpy`: This is a copy of the list of `uint8_t` values that represent pixel values in the image. This will be helpful with some of the algorithms later on in the lab.
- `img_width`: Number of pixels in each row in the image.
- `img_height`: Number of rows of pixels in the image.
- `pxl_data_size`: Size (in bytes) of `pxl_data`.


### Bitmasking
Bitmasking is is a method that allows us to manipulate (set to 1 or 0) certain bits of data. This is done general by making use of bitwise ORs, ANDs, and XORs.

For example if we wanted to select nothing but the last two bits of the byte (in binary) `11101011` we would use AND with a 0 on all the values we don't want and a 1 on all the values we do want in our selection:

```
     11101011
AND  00000011   <--- This value is known as the 'mask'
-------------
     00000011   <--- The masked value
```
although this is most obvious when representing the numbers as binary, the masking principles work for any representation of numbers.

If we wanted to recreate the following operation in C with hexademical numbers, it would be the following:

```c
uint8_t number = 0xEB;
uint8_t mask   = 0x03;

// Mask the numbers
number = number & mask; // number = 0x03
```

### Pixel Values in BMP file
The data you will be manipulating in this lab are the color channels of a pixel in a bitmap (or BMP) file. Each pixel is represented by three groups of colors: `BLUE`, `GREEN`, and `RED`:

<figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/image/pixels.png %}" alt="Units of the course.">
  <figcaption style="text-align: center;">This is how color values are stored in the BMP. In image processing, a row of these pixels is also called a stride.</figcaption>
</figure>

Different values of a color channels will provide different hues and shades of colors. If that isn't making too much sense, there is a wonderful visualation of how different color channels create different pixel colors [here](https://www.w3schools.com/colors/colors_picker.asp).

Each color channel is exactly 8 bits long (or one byte). Look at the `pxl_data` field in the `Bitmap` struct shown above. What type does it use? (Feel free to ignore the star).

While creating the algorithms below, keep in mind that the values are stored as color channels and **NOT pixels**.

Specifically in the BMP file, the values begin from the bottom left and fill up the row right to left and fill up the screen bottom to top.

#### Important warning about BMP rows:
In BMPs, the rows **MUST** be multiples of 4 bytes. This means if the image has a width that is not a multiple of 4, the BMP file employs padding to fufill that requirement.

While you are not responsible of adding this padding, you will need to take into account that you loop over each row applying the following algorithms. The easiest way to do this is to round up your loop limit to the nearest factor of 4.

## Requirements
In the code provided in this lab, you will be expected to edit the original image listed at the top of this page to provide some fun visual effects!

Much of the code has been given for you, but you are expected to follow the comments in the files and fill in logic for both the `remove_color_channel()` function and the `or_blur()` function.

### Remove Color Channel
In this function, you are expected to create logic that will allow a user to specify a color channel and have that color removed completely from the image. As you can see in the figures below, each image has either the red, green, or blue values set to 0.

<figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/image/red_mask.bmp %}" alt="Units of the course.">
  <figcaption style="text-align: center;">Original.bmp with all of the red values masked out.</figcaption>
</figure>

<figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/image/green_mask.bmp %}" alt="Units of the course.">
  <figcaption style="text-align: center;">Original.bmp with all of the green values masked out.</figcaption>
</figure>

<figure class="image mx-auto" style="max-width: 750px">
  <img src="{% link assets/image/blue_mask.bmp %}" alt="Units of the course.">
  <figcaption style="text-align: center;">Original.bmp with all of the blue values masked out.</figcaption>
</figure>

These images are the answer to your function! If you have done it correctly, your output should look exactly like whats above.

### OR Blur

This function will be the culmination of your data manipulation knowledge that you have learned up until now. In this function you will take each color channel value and bitwise OR it with the value directly above and below it.

Make sure to use the `pxl_data_cpy` list as your values that you are changing inside of your `pxl_data` list. If you use the `pxl_data` as your reference data, you will have compounding effects that will cause the image to be indistinguishable. This is not correct.

## Submission

- Answer the questions in the `README.md`. 

- To successfully submit your lab, you will need to follow the instructions in the [Lab Setup]({{ site.baseurl }}/lab-setup) page, especially the **Commiting and Pushing Files** and **Tagging Submissions** section.

## Resources

- [Bitwise Operations in C](https://en.wikipedia.org/wiki/Bitwise_operations_in_C)
- [Bit Masking](https://en.wikipedia.org/wiki/Mask_(computing))
- [Struct in C](https://www.tutorialspoint.com/cprogramming/c_structures.htm)
- [Enum in C](https://www.tutorialspoint.com/enum-in-c)
