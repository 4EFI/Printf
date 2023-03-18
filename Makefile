
include SOURCES

#compiling & linking

OBJ_TMP = $(subst .asm,.o,       $(SRC))
OBJ     = $(subst src,src/build, $(OBJ_TMP))

#compiling
                                             
link : $(OBJ) 
	ld -s -o $(OUTPUT_FILE_NAME) $^

src/build/%.o : src/%.asm	
	echo  $(@D)
	mkdir -p $(@D)
	nasm -f elf64 -o $@	$^

clear :
	rm   -f ./src/build/*.o    