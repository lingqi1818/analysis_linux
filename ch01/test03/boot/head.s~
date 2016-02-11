# 
# 本程序功能为：A，B进程在时钟中断都干扰下，轮流切换，并打印A和B
# author:ke.chenk             		            
# mail:lingqi1818@gmail.com
#
# 注意：此时程序已经进入保护模式，所以寻址方式为：段选择子+偏移
.globl startup_32
.code32
.data
SCRN_SEL	= 0x18 #显存选择子
TSS0_SEL	= 0x20
LDT0_SEL	= 0x28
TSS1_SEL	= 0x30
LDT1_SEL	= 0x38
LATCH		= 11930
.text
startup_32:
	mov	$0x10,%eax	# 数据段选择子
	mov	%ax,%ds		# 非常重要，设置错误无法加载gdt
	lss	init_stack,%esp
	call setup_idt
	call setup_gdt
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	mov %ax,%fs
	mov %ax,%gs
	lss init_stack,%esp
	#设置8253定时器
	movb	$0x36,%al	#通道0，工作方式为3
	movl	$0x43,%edx
	outb	%al,%dx
	movl	$LATCH,%eax	#1193180为8253的工作频率，这里需要每10毫秒响应一次，那么将数字设置为1193180/100
	movl	$0x40,%edx
	outb	%al,%dx
	movb	%ah,%al
	outb	%al,%dx
	
	movl	$0x00080000,%eax
	movw	$time_interrupt,%ax
	movw 	$0x8E00,%dx	#中断门类型，特权级为0
	movl	$0x08,%ecx	#开机时bios设置的时钟中断向量号，这边直接使用它，你也可以通过对8259A芯片的设置改变向量号.
	lea	idt(,%ecx,8),%esi	#将idt+ecx*8的地址写入esi
	movl	%eax,(%esi)
	movl	%edx,4(%esi)
	movw	$system_interrupt,%ax
	movw 	$0xef00,%dx	#陷阱门类型15，特权级为3
	movl	$0x80,%ecx	#系统调用向量号是0x80
	lea	idt(,%ecx,8),%esi	#将idt+ecx*8的地址写入esi
	movl	%eax,(%esi)
	movl	%edx,4(%esi)
	
	pushfl	#将32位eflag标志寄存器入栈

	#置NT标志为0
	#嵌套任务标志NT(Nested Task)
	#嵌套任务标志NT用来控制中断返回指令IRET的执行。具体规定如下：
	#(1)、当NT=0，用堆栈中保存的值恢复EFLAGS、CS和EIP，执行常规的中断返回操作；
	#(2)、当NT=1，通过任务转换实现中断返回。
	andl	$0xffffbfff,(%esp)
	popfl
	movl	$TSS0_SEL,%eax		#把任务0的TSS段选择子加载到任务寄存器TR
	ltr	%ax
	movl	$LDT0_SEL,%eax
	lldt	%ax
	movl	$0,current
	sti
	#构造iret指令返回前的堆栈状况,iret需要弹出eflag.
	pushl	$0x17	#调用者ss 此时段选择子的ti位为1，RPL为3 数据段为0x10+7=0x17
	pushl	$init_stack	#调用者esp
	pushfl	#标志寄存器入栈
	pushl	$0x0f		#调用者cs,此时段选择子的ti位为1，RPL为3,代码段为0x08+7=0x0f
	pushl	$task0	#eip入栈
	iret
	
#die:	jmp	die



write_char:
	push	%gs
	pushl	%ebx
	movl	$SCRN_SEL,%ebx
	mov	%bx,%gs
	movl	scr_loc,%ebx
	shl	$1,%ebx # 屏幕中每个字符占2个字节，其中一个为属性字节
	movb	$0x0f,%ah # 0000: 黑底    1111: 白字
	mov	%ax,%gs:(%ebx)
	shr	$1,%ebx
	incl	%ebx
	cmpl	$2000,%ebx
	jb	1f
	movl	$0,%ebx
1:	movl	%ebx,scr_loc
	popl	%ebx
	pop	%gs
	ret	


scr_loc:.long 0 #屏幕当前位置
current:.long 0

ignore_int:
	push	%ds
	pushl	%eax
	movl	$0x10,%eax
	mov	%ax,%ds		#让ds指向内核数据段，因为中断程序属于内核
	movl	$67,%eax
	call	write_char
	popl	%eax
	pop	%ds
	iret

system_interrupt:
	push %ds
	pushl %edx
	pushl %ecx
	pushl %ebx
	pushl %eax
	movl $0x10, %edx
	mov %dx, %ds	#局部数据需要用到
	call write_char
	popl %eax
	popl %ebx
	popl %ecx
	popl %edx
	pop %ds
	iret

time_interrupt:
	push %ds
	pushl %eax
	movl $0x10, %eax
	mov %ax, %ds
	movb $0x20, %al
	outb %al, $0x20	#发送EOI命令，清空ISR寄存器，让CPU能接受后面都中断。
	movl $1, %eax
	cmpl %eax, current
	je 1f
	movl %eax, current
	ljmp $TSS1_SEL, $0
	jmp 2f
1:	movl $0, current
	ljmp $TSS0_SEL, $0
2:	popl %eax
	pop %ds
	iret


setup_gdt:
	lgdt lgdt_opcode
	ret

setup_idt:
	lea ignore_int,%edx	
	movl $0x00080000,%eax
	movw %dx,%ax		#eax为选择子（0x0008）+偏移
	movw $0x8E00,%dx	#中断门类型，特权级为0
	lea idt,%edi
	mov $256,%ecx
rp_sidt:movl %eax,(%edi)	#将eax中都值放入%edi中指向都地址
	movl %edx,4(%edi)	#将edx放入%edi+4指向都地址，这样一个中断门构造完毕
	addl $8,%edi		#将edi中的指针偏移8个字节
	dec	%ecx
	jne	rp_sidt
	lidt	lidt_opcode
	ret

lidt_opcode:
	.word (256*8)-1		#表长度
	.long idt		#基地址

lgdt_opcode:
	.word (end_gdt-gdt)-1
	.long gdt

idt:	.fill 256,8,0	#256个门描述符，每个8字节，门描述符和普通描述符类似.

gdt:	.quad 0x0000000000000000
	.quad 0x00c09a00000007ff	#代码段
	.quad 0x00c09200000007ff	#数据段
	.quad 0x00c0920b80000002	#显存段，界限为2*4k

	.word 0x0068, tss0, 0xe900, 0x0	# TSS0 descr 0x20	68为104个字节，因为G=0 DPL=3 TYPE=9 可用386TSS
	.word 0x0040, ldt0, 0xe200, 0x0	# LDT0 descr 0x28	TYPE=2 LDT
	.word 0x0068, tss1, 0xe900, 0x0	# TSS1 descr 0x30
	.word 0x0040, ldt1, 0xe200, 0x0	# LDT1 descr 0x38
end_gdt:
	.fill 128,4,0
init_stack:		#注意，汇编的堆栈是高地址向低地址伸展，所以，需要在之前开辟空闲都空间
	.long init_stack	#堆栈段偏移位置
	.word 0x10		#堆栈段同内核数据段

ldt0:	.quad 0x0000000000000000
	.quad 0x00c0fa00000003ff	# 0x0f, base = 0x00000	DPL为3
	.quad 0x00c0f200000003ff	# 0x17	DPL为3

ldt1:	.quad 0x0000000000000000
	.quad 0x00c0fa00000003ff	# 0x0f, base = 0x00000	DPL为3
	.quad 0x00c0f200000003ff	# 0x17	DPL为3

tss0:	.long 0 			/* back link */
	.long krn_stk0, 0x10		/* esp0, ss0 */
	.long 0, 0, 0, 0, 0		/* esp1, ss1, esp2, ss2, cr3 */
	.long 0, 0, 0, 0, 0		/* eip, eflags, eax, ecx, edx */
	.long 0, 0, 0, 0, 0		/* ebx esp, ebp, esi, edi */
	.long 0, 0, 0, 0, 0, 0 		/* es, cs, ss, ds, fs, gs */
	.long LDT0_SEL, 0x8000000	/* ldt, trace bitmap 这边bitmap的地址无效，而且任务也没有IO操作，随便乱写也无所谓，具体设置方法可以参考INTEL开发手册312页*/
	
	.fill 128,4,0	#stack0堆栈大小
krn_stk0:


tss1:	.long 0 			/* back link */
	.long krn_stk1, 0x10		/* esp0, ss0 */
	.long 0, 0, 0, 0, 0		/* esp1, ss1, esp2, ss2, cr3 */
	/*中断允许标志IF是用来决定CPU是否响应CPU外部的可屏蔽中断发出的中断请求。但不管该标志为何值，CPU都必须响应CPU外部的不可屏蔽中断所发出的中断请求，以及CPU内部产生的中断请求。具体规定如下：
	(1)、当IF=1时，CPU可以响应CPU外部的可屏蔽中断发出的中断请求；
	(2)、当IF=0时，CPU不响应CPU外部的可屏蔽中断发出的中断请求。*/
	.long task1, 0x200		/* eip, eflags */
	.long 0, 0, 0, 0		/* eax, ecx, edx, ebx */
	.long usr_stk1, 0, 0, 0		/* esp, ebp, esi, edi */
	.long 0x17,0x0f,0x17,0x17,0x17,0x17 /* es, cs, ss, ds, fs, gs */
	.long LDT1_SEL, 0x8000000	/* ldt, trace bitmap 这边bitmap的地址无效，而且任务也没有IO操作，随便乱写也无所谓，具体设置方法可以参考INTEL开发手册312页*/

	.fill 128,4,0
krn_stk1:

task0:
	movl $0x17, %eax
	movw %ax, %ds		#由于任务没有使用局部数据，这两句可以省略
	movb $65, %al              /* print 'A' */
	int $0x80
	movl $0xfff, %ecx
1:	loop 1b	#打印完A之后，休息一段时间
	jmp task0 

task1:
	movl $0x17, %eax
	movw %ax, %ds
	movb $66, %al              /* print 'B' */
	int $0x80
	movl $0xfff, %ecx
1:	loop 1b
	jmp task1

	.fill 128,4,0 
usr_stk1:
