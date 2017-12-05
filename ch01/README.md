# 本章涉及内核代码对应文件


## 1.协程

ch01/test04

## 2.fork

代码文件:/linux-4.5.2/kernel/fork.c

## 3.execve

代码文件:/linux-4.5.2/fs/exec.c

## 4.create_kthread

代码文件：/linux-4.5.2/kernel/kthread.c

## 5.pthread库

代码在glibc中的：/glibc-2.26/nptl，头文件为：/glibc-2.26/nptl/pthreadP.h


## 6.schedule

代码文件：/linux-4.5.2/kernel/sched/core.c

## 7.进程切换switch_to

代码文件：/linux-4.5.2/arch/x86/include/asm/switch_to.h

## 8.ngx_setaffinity

代码在nginx中的：/nginx-1.12.1/src/os/unix/ngx_setaffinity.c


## 9.memcached中的thread_init, create_worker

代码在memcached中的：/memcached-1.5.3/thread.c


## 10.systemtap监控

ch01/test05

## 11.d-trace监控

ch01/test06