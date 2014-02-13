#NOM    : makefile
#CLASSE : FS - FS078
#OBJET  : demo du programme Mchmod.asm
#HOWTO	: make; make clean
#AUTEUR	: Bruno Parmentier, 02/2014

demo:	Mchmod64 Demo
	@clear
	@./Demo

Mchmod: Mchmod.asm 
	nasm Mchmod.asm -o Mchmod.o -f elf
	ld Mchmod.o -o Mchmod -e main

Mchmod64: Mchmod.asm 
	nasm Mchmod.asm -o Mchmod.o -f elf32
	ld -m elf_i386 Mchmod.o -o Mchmod -e main

clean:
	rm -f Mchmod *.o fichier* *~
