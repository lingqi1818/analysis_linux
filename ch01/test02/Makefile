####################################
# Makefile for playos              #
# author:ke.chenk                  #
# mail:lingqi1818@gmail.com        # 
####################################

AS86	=as86 -0 -a
LD86	=ld86 -0
AS		= as
LD		= ld
##LD_FLAGS	=-s -x
LDFLAGS	=-m elf_i386 -Ttext 0 -e startup_32
##LD86_FLAGS	= -0 -s -o
LD86_FLAGS	= -0 -o
CC	=gcc -march=i386 $(RAMDISK)
CFLAGS	=-c -g

ARCHIVES=fs/fs.o mm/mm.o lib/string.o kernel/kernel.o
DRIVERS =kernel/blk_drv/blk_drv.a kernel/chr_drv/chr_drv.a
LIBS	=lib/lib.a
PLAYOS_SECTS	= boot/bootsect boot/setup tools/system
OBJS 		= test.o
CPP	=cpp -nostdinc -Iinclude
# 避免当目标文件存在都时候，goal不执行
.PHONY : all clean

.c.s:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -S -o $*.s $<
.s.o:
	$(AS)  -o $*.o $<

clean:
	rm -rf *.o

test: test.o
	$(LD)  -o test test.o
