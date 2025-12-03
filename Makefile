# ROM targets
ASMTARGET = hello-asm.gb
CTARGET   = hello-c.gb

# Source files
ASM_SRC = ASM/main.asm
C_SRC   = C/main.c

# SDCC / RGBDS tools
RGBASM  = rgbasm
RGBLINK = rgblink
RGBFIX  = rgbfix
LCC     = lcc

# --------------------
# ASM build
# --------------------
$(ASMTARGET): $(ASM_SRC)
	$(RGBASM) -o asm.o $(ASM_SRC)
	$(RGBLINK) -o $(ASMTARGET) asm.o
	$(RGBFIX) -v -r 0 $(ASMTARGET)

# --------------------
# C build
# --------------------
$(CTARGET): $(C_SRC)
	$(LCC) -o $(CTARGET) $(C_SRC)

# --------------------
# Run
# --------------------
run-asm: $(ASMTARGET)
	java -jar ~/Emulicious/Emulicious.jar $(ASMTARGET)

run-c: $(CTARGET)
	java -jar ~/Emulicious/Emulicious.jar $(CTARGET)

# --------------------
# Clean
# --------------------
clean:
	rm -f $(ASMTARGET) $(CTARGET) *.o *.rel *.map

# --------------------
# Build both
# --------------------
all: $(ASMTARGET) $(CTARGET)
