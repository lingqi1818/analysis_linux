# 本章涉及内核代码对应文件

# 1.atomic

代码位于：

/linux-4.5.2/arch/x86/include/asm/atomic.h

/linux-4.5.2/include/linux/types.h

# 2.spin_lock

代码位于：

/linux-4.5.2/include/linux/spinlock_types.h

这里针对x86下的实现：

/linux-4.5.2/arch/x86/include/asm/spinlock.h

# 3.Semaphore

代码位于：/linux-4.5.2/include/linux/semaphore.h


/linux-4.5.2/kernel/locking/semaphore.c

# 4.Mutex

代码位于：/linux-4.5.2/include/linux/mutex.h

/linux-4.5.2/kernel/locking/mutex.c

# 5.Rw-lock

代码位于：/linux-4.5.2/include/asm-generic/qrwlock_types.h

/linux-4.5.2/kernel/locking/qrwlock.c


# 6.Preempt

代码位于：/linux-4.5.2/include/linux/preempt.h

# 7.Per-cpu

代码位于：/linux-4.5.2/include/linux/percpu-defs.h

/linux-4.5.2/arch/x86/kernel/setup_percpu.c

# 8.rcu

代码位于：/linux-4.5.2/include/linux/rcupdate.h


# 9.volatile与内存屏障

ch02/test01

# 10.ngx atomic

代码位于：/nginx-1.12.1/src/os/unix/ngx_gcc_atomic_x86.h

/nginx-1.12.1/src/core/ngx_spinlock.c

# 11.Memcached针对item互斥锁

/memcached-1.5.3/thread.c

# 12.linux惊群中的问题

涉及到Linux的代码位于：/linux-4.5.2/kernel/sched/wait.c

/linux-4.5.2/net/ipv4/inet_connection_sock.c

# 13.mycat相关

涉及的代码位于：https://github.com/MyCATApache/Mycat-Server/blob/7cccdabd6dc86707b425033fe974136ed61eb5cf/src/main/java/io/mycat/MycatServer.java

# 14.false-sharing

ch02/test02
