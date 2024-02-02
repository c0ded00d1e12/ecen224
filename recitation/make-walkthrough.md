---
title: Make Walkthrough
layout: walkthrough
permalink: /:path/:basename
---
Make is a tool for building both simple and complicated projects. It can be used with pretty much any development tool that can be run from the command line. It's most common use is building compiled programs from source code. But it would be equally effective applying visual filters to raw camera images.

## Setup

For this walkthrough we'll be using the `gcc` C compiler and the Gnu `make` utility. You will also need a text editor. By now you probably have a development setup with these tools or you're working on a lab machine. 


To be sure your `gcc` and `make` are installed use the following command:
```bash
gcc --version
make --version
```

If you find they aren't installed you can install them with the following commands:
```bash
sudo apt install gcc
sudo apt install make
```

Let's start with a simple C program consisting of three source files. Create a folder (directory) for your project. In that folder create two .c and one .h source code files with the following contents:

**pasta.c**
```c
#include <stdio.h>
#include "servings.h"

int main()
{
    int servings = 5;
    int ounces = servings2ounces(servings);
    printf("You need %d ounces of dry pasta to make %d servings.\n", ounces, servings);
}
```

**servings.h**
```h
int servings2ounces(int servings);
```

**servings.c**
```c
#include "servings.h"

int servings2ounces(int servings)
{
    return servings * 3;
}
```

You can build this program with the following command:
```bash
gcc pasta.c servings.c -o pasta
```

Then you can run it with this command:
```bash
./pasta
```

## Compiling and Linking
The previous command actually performed three operations:
1. Compile pasta.c to machine language
2. Compile math.c to machine language
3. Link the machine language produced in steps 1 and 2 with the runtime libraries and put the result into the `pasta` executable file.

You can do these steps separately as follows:
```bash
gcc -c pasta.c
gcc -c servings.c
gcc pasta.o servings.o -o pasta
```

Each of the compile steps produced a corresponding _object_ file with a `.o` extension. The object files contain the machine code of the functions from the source files plus information needed to link them together into a executable program. The third, linking, step combines these files plus runtime libraries that into the executable file - with no extension.

But why do this in separate steps when the simple one-step build works?

Suppose you have a large application with dozens of source code files. Then you would only want to compile the files that have changed before linking everything together. That saves build time. Make orchestrates complicated build processes and does it in a simple way.

## Makefiles

A make file is composed of rules. Each rule has three parts; plus it may have a comment:

![Anatomy of a Make Rule](images/MakeRule.svg)

* The **target** is the thing that the rule is intended to create. If you were making a cake, it would be the cake itself.
* The **prerequisites** are the inputs for creating the target. Sort of like the ingredients to the cake.
* The **recipe** is the set of commands required to produce the target from the prerequisites.

A **Makefile** is a text file containing a set of rules. By default, the file is named just that, "Makefile" without any extension. Let's create one for our project.

**Makefile**
```
pasta: pasta.c servings.c servings.h
	gcc pasta.c servings.c -o pasta
```
IMPORTANT: You must use a tab to indent the lines of the recipe. Spaces won't work. So, in the second line of this Makefile, be sure to use a tab.

This is a very simple makefile with only one rule. It says that `pasta` (the executable file) depends on `pasta.c`, `servings.c`, and `servings.h`. If any of those files changes, then the recipe commands are executed to re-create it.

Let's run the make file. At the command-line just type the following:
```bash
make
```

Make automatically looks for a `Makefile` in the current directory and executes the rules in that file. When necessary, you can use the `-f` option to specify a different filename for the Makefile but that's uncommon.

If you already built `pasta` using the `gcc` command then make simply responds with "'pasta' is up to date." and does nothing. How does it know that that `pasta` is up to date? By checking the file modification dates. If the date modified on `pasta` is more recent than all of its prerequisites then the recipe doesn't need to be executed.

Let's test this. Make a change to `pasta.c`. You could change the message, add a comment, anything. In this example I changed "You" to "We" in the message:

**pasta.c**
```c
#include <stdio.h>
#include "servings.h"

int main()
{
    int servings = 5;
    int ounces = servings2ounces(servings);
    printf("We need %d ounces of dry pasta to make %d servings.\n", ounces, servings);
}
```

Now run make:
```bash
make
```

This time it executes the command to build `pasta`. Run `make` again and it will report that `pasta` is up to date.

Of course, this simple make file just builds the whole thing whenever something changes. A better `Makefile` would only build what's necessary.

## Multiple Rules

Update your `Makefile` as follows:
```
pasta: pasta.o servings.o
	gcc pasta.o servings.o -o pasta

pasta.o: pasta.c servings.h
	gcc -c pasta.c

servings.o: servings.c servings.h
	gcc -c servings.c
```
Again, make sure those are tabs on the indents and not spaces. Conveniently, most editors such as VS code recognize `Makefile` as a particular format and insert literal tabs when you press the `Tab` key.

Run this version of the Makefile
```
make
```

This version compiles each .c file separately and then links them together. Of course, the rules are in the opposite order with the linking coming first and then the compiling of each source file. This is because the first target in a `Makefile` is the default - the final result that the Makefile is supposed to build.

Run the `make` again and it will report that everything is up to date.

## Touch

The `touch` command is handy when experimenting with `make`. `touch` simply updates the modified date of a file. So, `make` will treat that file as if it has been modified.

Run the following commands:
```bash
touch servings.c
make
```

It compiles `servings.c` into `servings.o` and then links everything together. It didn't need to recompile `pasta.c` because it hadn't changed.

Try this:
```bash
touch servings.h
make
```

This time it compiles both source files. That's because they both depend on `servings.h`.

## Other Targets

Add a `clean:` target to your `Makefile` so it looks like this:

**Makefile**
```
pasta: pasta.o servings.o
	gcc pasta.o servings.o -o pasta

clean:
	rm *.o
	rm pasta

pasta.o: pasta.c servings.h
	gcc -c pasta.c

servings.o: servings.c servings.h
	gcc -c servings.c
```

Notice that the `clean:` rule comes after the `pasta:` rule. That's because we want to keep `pasta:` as the default rule.

Type the following command:
```
make clean
```

It removes all `.o` object files and the final `pasta` executable file leaving the directory with just the source files.

Now type:
```
make
```

It rebuilds the whole project from scratch.

## More Make

Make has a lot of options for more sophisticated Makefiles than these. It has variables, pattern rules, string substitution and more. The [Makefile Tutorial](https://makefiletutorial.com) is an excellent resource for learning the details. But for our purposes, the simple rules in the walkthrough are sufficient.