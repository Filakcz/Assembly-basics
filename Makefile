add:
	nasm -f elf64 add.asm -o add.o
	ld add.o -o add.x86_64
	./add.x86_64

hello:
	nasm -f elf64 hello.asm -o hello.o
	ld hello.o -o hello.x86_64
	./hello.x86_64

gcd:
	nasm -f elf64 gcd.asm -o gcd.o
	ld gcd.o -o gcd.x86_64
	./gcd.x86_64
