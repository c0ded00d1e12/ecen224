---
title: Compile-To-Assembly Walkthrough
layout: walkthrough
permalink: /:path/:basename
---
The Binary Bomb lab has six phases. To decode each phase, you need to understand how a more complex C construct appears in Assembly language. One tool to help understand things is to compile your own code to assembly language and look at the result.

If you use the following compile options, the compiler will produce a rich, commented assembly language file for you to examine:

```
gcc -S -O0 -fverbose-asm -fno-asynchronous-unwind-tables -fno-pie yourcode.c
```
The options are:
* `-S` Compile to assembly language
* `-O0` Use optimization level 0 (no optimization). Other options are `-O1`, `-O2`, and `-O3`.
* `-fverbose-asm` Writes detailed comments into the assembly language
* `-fno-asynchronous-unwind-tables -fno-pie` Removes extra code that makes it harder to understand what's going on. (Look up the options for details)

## Useful Links

Before trying to decode assembly, it's valuable to have a reference for the opcodes. Here are some good choices:

* [Alphabetical Instruction Reference](https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf)
* [Stanford X86-64 Reference Sheet](https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf)
* [X86 opcode and Instruction Reference](http://ref.x86asm.net/)

> For most instructions, the opcode is the same in AT&T and Intel syntax except that AT&T syntax adds a suffix representing the size of the operand. One exception is `cltq` which means "Convert Long to Quad". In Intel syntax the opcode is `cdqe` meaning "Convert Double to Quad Extend". Just another way of saying the same thing. When no operand is given, `cdqe` operates on `rax`. Related instructions are `cwde` (Intel `cwtl`) which converts 16-bit words to 32-bit double-words and `cbw` (Intel `cbtw`) which converts bytes to 16-bit words.

## For Loop

First, let's try a `for` loop that generates multiples of 5 and writes them into an array.

Put this in a file called `loop.c`:
```
void loop() {
    int a[10];
    for (int i=0; i<10; ++i) {
        a[i] = i*5;
    }
}
```

Compile it to assembly:
```
gcc -S -fverbose-asm -fno-asynchronous-unwind-tables -fno-pie yourcode.c
```

The annotated assembly code will be in a text file named `loop.s`. Examine the contents. Notice how it places a test for `i<=9` (instead of `i<10`) at the end of the loop and jumps to the end before looping back to the top of the loop.

* Right as the loop begins, it does an XOR of %eax with %eax. What does that accomplish?
* Can you tell where the variable `i` is stored?
* Can you tell where the array `a` is stored?
* There's no `mul` opcode. How does it go about multiplying by 5?
    * Hint: Look for `sal` which is `shift arithmetic left` followed by an `add`. Remember the suffixes for operand size.

## Switch Statement

Put this in a file called `switch.c`:
```
int switchit(int a) {
    switch(a) {
        case 1:
            return 12;
        case 2:
            return 9;
        case 3:
            return 42;
        default:
            return 0;
    }
}
```

Compile it to assembly using the options listed above. Examine the result.

In the branching section you find a series of `cmpl` statements followed by `je`, `jl`, or `jg` statements. The `cmp` opcode performs a subtraction and sets the flags but doesn't store the result. Among the flags are `zero` and `negative`. The `jx` operations are conditional jumps:

* `jl`: Jump if less - Jump if the negative flag is set.
* `je`: Jump if equal - Jump if the zero flag is set. (The `jz` opcode means "Jump if zero" and compiles to the same machine code.)
* `jg`: Jump if greater - Jump if the negative flag and the zero flag are both zero.

* Can you find the assembly labels for the code corresponding to each case in the switch statement?
* How are the jump statements organized?
* If there were ten cases do you think there would be ten comparisons or would the compiler find a different optimization?

> The binary bomb takes a different approach to switch statements. Likely because of different optimization settings. Try experimenting with different optimization levels (`-O0`, `-O1`, `-O2` or `-O3`) to see the effect.

## Pointer

Put this in a file called `pointer.c`
```
// The argument passed to this function should
// be an array of at least three integers.
int add(int *p) {
    return *p + *(p+1) + *(p+2);
}
```

Compile to assembly using the options above and review the result.

* Can you see how it references the values *p, *(p+1), and *(p+2)?
* Where does it accumulate the results of the two additions?
* What happens when you use different levels of optimization?



