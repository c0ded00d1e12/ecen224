---
title: I/O
number: 7
layout: lab
---

## GitHub Classroom
Use the GitHub Classroom link posted in the Slack channel for the lab to accept the assignment.

## Objectives

- Read in files into a program
- Create the necessary logic to handle an interface
- Filter out files by pattern

## Overview

Learning to interact with the peripherals of the Pi Z2W is what allows us to take a simple single board computer and turn it into a system with a more directed purpose. You may have noticed by looking at the future lab names of this class that the culmination of this project is to make a smart doorbell system. To that end, a HAT with an LCD screen and some buttons has been provided. Its purpose is to provide a way for a user of your smart doorbell to directly interact with the computer that is powering it.

In the last lab you were able to draw practically anything to the LCD screen by utilizing the provided vendor libraries. You were also able to correlate these drawing events with button presses. In this lab we will take this practice and put it towards a more practical use: creating a photo and log viewer for your doorbell.

The photo and log viewer of this lab consists of several components: scanning the folder where the intended files live, filtering out any files that the photo and log viewer doesn't care about, and displaying the intended content of each file.

### Scanning the Folder
In this lab you are expected to scan through a current folder and make a list of strings that indicate the contents of that folder. While this is as trivial as a simple `ls -al` command in the shell, it comes more challenging when trying to achieve the same objective in C. Implement the following directions from the sections below to create an array of strings that contain all of the files of interest inside the `viewer` folder. Your scanning function should filter out anything that doesn't end in `.bmp` or `.log`.

#### DIR Pointer
Before we can read in the contents of a directory in C, we will need a variable that holds some information about the directory that we are reading. For this, we use a `DIR` pointer. This object will allow us to look at the location of where our directory lives and then use this a pointer to iterate through files in a directory and (for our purposes) retrieve those file names. To make this pointer:
```c
DIR *dp;    // Creates a directory pointer dp
```

#### Folder operations
With our newly allocated `DIR` pointer, we can use the following functions that will help us interface with the directory in our code.

- `opendir()` and `closedir()`

    In order to open a directory while using the `DIR` pointer, you can do the following:
    ```c
    DIR *dp;
    dp = opendir("my-folder");
    ```
    This opens the `my-folder` directory into code and puts the `dp` pointer at the top of this directory. When we are done iterating through the directory, you will need to close it by using the following call to `closedir()`:
    ```c
    closedir(dp);
    ```

#### Parsing through the Folder
While iterating through a directory, you will need to have an object that corresponds to the files that are inside the directory. This object is known as the `struct dirent` pointer and is the return value of `readdir()`. In other words, when we call `readdir()` on a `DIR` pointer, it will iterate through a linked-list that returns the files in a form of a `dirent` struct pointer. Once we have finished iterating through all of the files in a `DIR` pointer, `readdir()` will return `NULL`:

- `readdir()` example:

    ```c
    DIR *dp;                // Directory pointer
    bool is_file = True;    // Flag that denotes whether we have seen all the files in a folder
    struct dirent * dir;    // Current folder object
    while(is_file)
    {
        dir = readdir(dp);
        if(dir == NULL)
        {
            is_file = false;
        }
    }
    ```

- `d_name`
    The `d_name` value inside of the `dirent` struct holds the file name of the file we are looking at. In order to see what the name of the current file is from a `readdir()` operation:
    ```c
    char file_name[256];                                    // File name string
    dir = readdir(dp);                                      // Get the current file object
    strncpy(file_name, dir->d_name, strlen(dir->d_name));   // Copy the file object name to the file_name string
    ```

#### Filtering Files
While reading in your files using the folder operations, you may want to filter out some folders or files that are not of interest to you such as the `.` and `..` files that exist in every directory. To do this, you can check the name of the filename with the `strncmp()`. If the files match a certain value (i.e. last 3 characters of the name are `bmp` or `log`), you can add them to a list, else you can ignore it. More reading on how to use `strncmp()` is found in the **Explore More!** section below.

### Reading Files
In this lab you will be expected to read both `.bmp` and `.log` files from the `viewer` folder. Then you must show them on the LCD screen of your Pi Z2W. In order for your program to input these files in code so you can interact with them, you will need to become familiar with some basic C constructs such as `FILE` streams and their associated functions. The information in the following section should help you become successful in reading in files into C and writing them to a different destination (i.e. in this case, to your LCD screen).

#### FILE Pointers
Interacting with a file will require you to make a `FILE` stream pointer. This pointer represents the current position of where a read or a write action is inside of a file. For example, if you open a file to read for the first time, the pointer will be at the beginning of the document. As you read words by advancing the pointer position with functions such as `fscanf()` or `fread()`, the pointer value will increment. For the purposes of this lab, we will use `FILE` pointers only in the context of the functions needed for the file operations described below. To declare a FILE pointer:

```c
FILE *fp;    // This declares a file pointer that is read to be used in file operations
```

#### File Operations
There are a few essential file operations that exist in the `stdio.h` library. The following is a selection of functions that will help you with to input files into a location in your code.   

- `fopen()` and `fclose()`

    This function takes in a `FILE` stream pointer, a file path, and some special strings to indicate the mode as arguments for opening a file. For example:

    ```c 
    FILE *fp;    // File pointer for interacting with file.
    fp = fopen("fancy_output.log", "r");
    ```
    this code will create a `FILE` stream pointer called `fp`. We then use `fopen` to set the location of `fp` to the beginning of the `fancy_output.log` file in the current directory with the `r`ead mode (look at the **Explore More!** section for different file modes).

    Once we have done everything that we want to with the file, we must be responsible and release the pointer back to the system. This is done by closing the file using `fclose()`. To do this, simply do the following:
    ```c
    fclose(fp);    // Closes the file that was attached to the fp pointer
    ```

- `fscanf()`

    Once we have a file open, what can we actually do with the `FILE` stream pointer in order to actually get data? This is where functions like `fscanf()` come into play. This function takes a file pointer as an argument and reads data from it. For example, if I wanted the first word from our `fancy_output.log` file that we opened above, I could do the following to get the first word from the document:
    ```c
    char word[256];            // Creates a string that can hold up to 256 characters 
    fscanf(fp, "%s", word);    // Reads in a single word from fp as a string (%s) into the word variable
    ```

### Creating a Functional Interface

There are many ways to accomplish creating a functional interface that will display files and allow you to interact with them. The algorithm that I have used to successfully complete the lab is as follows:
- Scan through the `viewer` folder and create an array of strings of all the valid files that will need to be shown in the viewer.
- Draw a list of all the correct file names.
- Create a function for drawing the sample text of a log file to the LCD screen.
- Call that function or `display_draw_image()` when the currently selected file is highlighted.
- Comply with all the requirements below.

## Requirements

In this lab you should accomplish the following:
- Create a simple menu that lists all of the files in the `viewer` folder:
    - Filter out any file that does not end in `.bmp` or `.log`
    - File names should be drawn in 8pt font with a BLACK foreground
    - A selection bar should highlight which file you are about to open
        - When the up and down buttons are pressed (left and right in code), the selection bar should move and highlight the next or previous entry.
        - When the selection bar is over a file name, the background color of the next should match the color of the selection bar, when it is deselected, it should go back to the default background color.
- When the center button is pressed do the following:
    - If the file is a `.bmp` image, display the corresponding image for 2 seconds and then go back to the menu view with the highlight bar over the selected image
    - If the file is a `.log` file, display the contents of the file:
        - You are responsible for handling new lines
        - You must wordwrap your lines
        - If a file is too long for the screen, truncate the output by filling out as much text as possible and then adding an ellipse (`...`) at the end
        - This content must appear for 2 seconds and then go back to the menu view with the highlight bar over the selected image

## Submission

### Compilation
Since a large portion of this lab's grade depends on me successfully compiling your code, the following points must be adhered to to ensure consistency in the grading process. Any deviation in this will result in points off your grade:

- The code in this lab will be compiled at the root of this lab repository (i.e. `io-<your-github-username>`). It is your responsibility to ensure that `gcc` will work from this directory.
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
- [List Files in Folder in C](https://stackoverflow.com/questions/4204666/how-to-list-files-in-a-directory-in-a-c-program)
- [Opening and Closing a File in C Tutorial](https://www.programiz.com/c-programming/c-file-input-output#:~:text=()%20returns%20NULL.-,rb,Open%20for%20writing.)
- [`fscanf()` Tutorial](https://www.tutorialspoint.com/c_standard_library/c_function_fscanf.htm)
- [Comparing strings in C](https://www.tutorialspoint.com/c_standard_library/c_function_strncmp.htm)