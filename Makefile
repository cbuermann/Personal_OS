run:
	nasm -f bin src/boot.asm -o bin/boot.bin
	qemu-system-x86_64 -fda bin/boot.bin

clean:
	rm -f bin/*