# $< expands to the first prerequisite of the rule
ASM=fasm
SRC=hello.asm
OUT=hello

all: $(OUT)

$(OUT): $(SRC)
	$(ASM) $<

hexdump: $(OUT)
	xxd -g1 $(OUT)

clean:
	rm -f $(OUT)
