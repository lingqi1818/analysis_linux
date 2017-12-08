# 本章涉及内核代码对应文件

# 1.IRQ中断

代码位于：/linux-4.5.2/arch/x86/kernel/irqinit.c

# 2.中断响应

代码位于：

/linux-4.5.2/arch/x86/entry/entry_32.S

/linux-4.5.2/include/linux/irqdesc.h

/linux-4.5.2/kernel/irq/handle.c

/linux-4.5.2/include/linux/interrupt.h

/linux-4.5.2/kernel/irq/manage.c

# 3.softirq

代码位于：/linux-4.5.2/kernel/softirq.c

# 4.tasklet

代码位于：/linux-4.5.2/include/linux/interrupt.h

/linux-4.5.2/kernel/softirq.c

# 5.workqueue

代码位于：/linux-4.5.2/include/linux/workqueue.h

/linux-4.5.2/kernel/workqueue.c

# 6.syscall

代码位于：/linux-4.5.2/arch/x86/kernel/traps.c

/linux-4.5.2/arch/x86/entry/entry_32.S

/linux-4.5.2/arch/x86/entry/common.c

/linux-4.5.2/arch/x86/entry/syscall_32.c

/linux-4.5.2/include/uapi/asm-generic/unistd.h

# 7.时钟中断

代码位于：/linux-4.5.2/arch/x86/kernel/time.c

# 8.信号处理

代码位于：/linux-4.5.2/kernel/signal.c

/linux-4.5.2/arch/x86/entry/entry_32.S

# 9.kill的代码

代码位于：/linux-4.5.2/kernel/signal.c