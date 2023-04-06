
include SOURCES

#compiling & linking

OBJ_TMP = $(subst .asm,.o,       $(SRC))
OBJ     = $(subst src,src/build, $(OBJ_TMP))

#compiling
                                             
link : $(OBJ) 
	gcc -no-pie -o $(OUTPUT_FILE_NAME) $^
	gcc -no-pie -o main src/main.cpp src/build/printf.o src/build/num_cnvrt.o

src/build/%.o : src/%.asm	
	mkdir -p $(@D)
	nasm -f elf64 -o $@	$^

clear :
	rm   -f ./src/build/*.o    