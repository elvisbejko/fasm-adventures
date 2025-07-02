FASM_URL := https://flatassembler.net/fasm-1.73.32.tgz
FASM_TAR := fasm.tgz
FASM_DIR := fasm
FASM_BIN := $(FASM_DIR)/fasm
INSTALL_BIN := /usr/local/bin/fasm

.PHONY: all clean distclean download hexdump-%

# Collect all .asm files in current directory
ASM_SOURCES := $(wildcard *.asm)

# Define corresponding output binaries (no extension)
OUTS := $(ASM_SOURCES:.asm=)

all: $(OUTS)

# Fallback path if fasm is not in PATH
$(INSTALL_BIN):
	@echo "fasm not found. Installing system-wide..."
	wget --show-progress $(FASM_URL) -O $(FASM_TAR)
	tar -xzf $(FASM_TAR)
	sudo install -m 755 $(FASM_BIN) $(INSTALL_BIN)
	rm -rf $(FASM_TAR) 

# Use system fasm if available, fallback to installed copy
FASM := $(shell which fasm 2>/dev/null)
ifeq ($(FASM),)
FASM := $(INSTALL_BIN)
$(OUTS): $(INSTALL_BIN)
endif

# Pattern rule to build output from .asm source
# $@ = target (output file), $< = first prerequisite (source .asm)
%: %.asm
	$(FASM) $<

# Pattern rule to print hexdump of a binary
hexdump-%:
	xxd -g1 $*

clean:
	rm -f $(OUTS) *.bin

distclean: clean
	rm -f $(FASM_TAR)
	rm -rf $(FASM_DIR)

download:
	wget -q $(FASM_URL) -O $(FASM_TAR)
	tar -xzf $(FASM_TAR)
	rm -f $(FASM_TAR)
