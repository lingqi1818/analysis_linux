!
! 引导设备引导区代码，注意，本程序编译完之后生成的内容最多不能超过512K
! author:ke.chenk             		            
! mail:lingqi1818@gmail.com
!
! 以下为BIOS中断—直接磁盘服务(Direct Disk Service——INT 13H)读扇区都参数说明：
! 功能02H
!
! 功能描述：读扇区
!
! 入口参数：AH＝02H AL＝扇区数 CH＝柱面 CL＝扇区 DH＝磁头
! DL＝驱动器，00H~7FH：软盘；80H~0FFH：硬盘
! ES:BX＝缓冲区的地址
!
! 出口参数：CF＝0——操作成功，AH＝00H，AL＝传输的扇区数，否则，AH＝状态代码，参见功能号01H中的说明


.global begtext, begdata, begbss, endtext, enddata, endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text
BOOTSEG = 0X07c0 ! BIOS加载boot代码到指定的内存地址（原始段地址）（31k） 0x7c0是boot所在的段值，或者说单位是“节”（16字节）。换算成基地址值需要乘16，即0x7c00
! 总共有20根地址线也就是20位寻址.
! 0x07c0 是表示高16位地址位.
! 基地址是等于0x07c0加上四位二进制的位也就是一个十六进制的值=0x07c00

SYSSEG	= 0X1000 ! 先把内核（head.bin）复制到内存地址0x1000处
SYSLEN	= 17 ! 内核占用都最大磁盘扇区数
entry start !告知链接程序，程序从start处开始执行
start:
	jmpi go,#BOOTSEG ! 段间跳转，go是偏移地址
go:	mov ax,cs
	mov ds,ax
	mov ss,ax
	mov sp,#0x400 ! 设置临时栈指针。只要值大于0x200（512）即可。本程序中，此处都栈没有用处。
	
! 加载内核代码到内存0x1000处
load_system:
	mov dx,#0x0000 ! DH磁头号，DL驱动器号。
	mov cx,#0x0002	!CH磁道号（共10位）高八位，CL6，7未为磁道号低两位。CL0-5为起始扇区号。（从1开始，head在boot扇区之后，所以为2）
	mov ax,#SYSSEG
	mov es,ax
	xor bx,bx	! EX：BX 读入缓冲区位置为,0X1000:0x0000
	mov ax,#0X200+SYSLEN ! 入口参数：AH＝02H AL＝扇区数
	int 0x13
	jnc ok_load ! jnc是一条跳转指令，当进位标记C为0时跳转，为1时执行后面的指令。
die:	jmp die ! 死循环
ok_load:
	cli	! 关闭中断
	! 移动开始位置 ds:si=0x1000:0,目标地址 es:di 0x0000:0
	mov ax,#SYSSEG
	mov ds,ax
	xor ax,ax
	mov es,ax
	mov cx,#0x2000 ! 移动4K次，每次移动一个字（内核长度不超过8K）
	sub si,si
	sub di,di
	! rep的转换：每次执行的时候先执行cx=cx-1然后判断cx是否为0，如果是0说明REP MOVW这个指令执行完毕了，直接跳转执行REP MOVSW的下一行语句，
	! 如果不为0,执行movw也就是数据转移一次。
	rep ! 重复执行后面都movw（每次移动一个字（16位）），这是2条指令，必须分开写
	movw
	mov ax,#BOOTSEG
	mov ds,ax ! ds重新指向 0x7c00处
	lidt idt_48
	lgdt gdt_48
	
	mov 	ax,#0x0001	! 设置cr0寄存器，保护模式标志PE=1
	lmsw	ax
	jmpi	0,8		! 跳转到段1，偏移0处执行
	
gdt:	.word	0,0,0,0 ! 段描述符0，不用（每个描述符占8个字节，描述符都说明可以查看intel开发手册或是于渊例子《自己动手编写操作系统》中都pm.inc文件）

	.word	0x07FF	! 段描述符1，界限8M(2048*4K)
	.word	0x0000	
	.word	0x9A00  ! 是代码段，可读/执行
	.word	0x00C0	! 颗粒度为4K

	.word	0x07FF	! 段描述符2，界限8M(2048*4K)
	.word	0x0000
	.word	0x9200 ! 是数据段，可读/写
	.word	0x00C0

idt_48:	.word	0
	.word	0,0
gdt_48:.word	0x7ff ! GDB长度2048字节，最多可以有256个描述符
	.word	0x7c00+gdt,0 ! gdt表基地址从0x7c00+gdt处开始
.org	510
	.word	0xAA55
.text
endtext:
.data
enddata:
.bss
endbss:
