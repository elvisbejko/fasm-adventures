FASM_URL := https://flatassembler.net/fasm-1.73.32.tgz
FASM_TAR := fasm.tgz
FASM_DIR := fasm
FASM_BIN := $(FASM_DIR)/fasm
INSTALL_BIN := /usr/local/bin/fasm
SRC := hello.asm
OUT := hello

.PHONY: all clean distclean

all: $(OUT)

# Fallback path if fasm is not in PATH
$(INSTALL_BIN):
	@echo "fasm not found. Installing system-wide..."
	wget -q $(FASM_URL) -O $(FASM_TAR)
	tar -xzf $(FASM_TAR)
	sudo install -m 755 $(FASM_BIN) $(INSTALL_BIN)
	rm -rf $(FASM_TAR) $(FASM_DIR)

# Use system fasm if available, fallback to installed copy
FASM := $(shell which fasm 2>/dev/null)
ifeq ($(FASM),)
FASM := $(INSTALL_BIN)
$(OUT): $(INSTALL_BIN)
endif

$(OUT): $(SRC)
	$(FASM) $<

hexdump: $(OUT)
	xxd -g1 $(OUT)

clean:
	rm -f $(OUT)

distclean: clean
	rm -f $(FASM_TAR)
	rm -rf $(FASM_DIR)
