# GB Hello World, ASM Vs C

Did you ever want to know if a simple Game Boy ASM program is more efficient than a Game Boy C program ?

So you are the correct place. ദ്ദി(˵ •̀ ᴗ - ˵) ✧

I'm going to show you why and how an ASM program can be smaller, faster, and more direct than a C program for the Game Boy.

---

## Overview

In this project I'm going to use [RGBDS](https://rgbds.gbdev.io/) and [GDBK-2020](https://github.com/gbdk-2020/gbdk-2020) to show `Hello World` on the Game Boy Screen

This project contains **2 Hello World programs** (1 in ASM and 1 in C):

1. [`main.asm`](Asm/main.asm) → written in **Assembly with RGBDS**
2. [`main.c`](C/main.c) → written in **C using GBDK**

---

## File Size

To compare the ROM size i've used:

```bash
stat -c %s hello-asm.gb hello-c.gb
```

Which give me:

|  ROM  |  Size (bytes)  |              Notes             |
|:-----:|:--------------:|--------------------------------|
|  ASM  |     16384      |       Just instructions        |
|   C   |     32768      | Includes GBDK runtime overhead |

> ASM is more efficient in terms of size

To get ASM file to `16Kb` i've used some technics.

1st, i've removed `INCLUDE "hardware.inc"` (it's "just" some macros) because I don't need it just for 4 terms so I've remplaced the macros by with the real addresses so you can remove `~23Kb` of the final weight.

2nd, with `GBDK` when you do a `printf("some text")` he will import `101` tiles to get all symbols needed (see image). So if you define your own font (tiles) you can reduce the size of the final file.

![GBDK Font Import](Assets/GBDKFont.png)

Here is my own font to print `Hello World`:

![My Light Font](Assets/LightFont.png)

---

## Output Screenshot

As you can tell there is literally no difference (graphically) between the C and ASM ROM:

`ASM`
![ASM](Assets/ASMScreen.png)

`C`
![C](Assets/CScreen.png)

---

## Build it

### Requirements

- [RGBDS](https://rgbds.gbdev.io/) (assembler and linker) for ASM
- [GBDK-2020](https://github.com/gbdk-2020/gbdk-2020) for C
- An Game Boy emulator (or even better a real one)

### Compile ASM

```bash
git clone https://github.com/squach90/ASM-VS-C-GB.git
cd ASM-VS-C-GB
make
```

Then run the ROMs with Emulicious or any Game Boy emulator to see the result.

Explanation :
`rgbasm`  -> compiles `main.asm` into a `asm.o`
`rgblink` -> links `asm.o` into a GB ROM
`rgbfix`  -> fixes the header and ensures correct size

[View ASM source code](ASM/main.asm)

[View Makefile](./Makefile)

### Compile C

```bash
git clone https://github.com/squach90/ASM-VS-C-GB.git
cd ASM-VS-C-GB
make hello-c.gb
```

Then run the ROMs with Emulicious or any Game Boy emulator to see the result.

Explanation :
`lcc` -> compiles `main.c` into a GB ROM

[View C source code](C/main.c)

[View Makefile](./Makefile)

---

## Conclusion

I really enjoyed creating this small program in ASM and I learned a lot in the process.
Manually managing everything: tiles, tilemaps, V-Blank, screen control, and other low-level details was definitely challenging.

That said, I will probably use ASM more often than C for small Game Boy projects.
C works perfectly fine and I definitely recommend it for ease of use, but ASM is way more fun and gives you full control over the hardware.

## 👀 🫵 ⏭️ ⏰ ヾ(＾ ∇ ＾).

### Boring stuff

This project is released under the [Unlicense](./UNLICENSE).

Created by [@squach90](https://github.com/squach90)

Read more on [my blog](https://squach90.github.io)
