# 本章涉及内核代码对应文件


# 1.分段代码

代码位于：/linux-4.5.2/arch/x86/kernel/cpu/common.c

/linux-4.5.2/arch/x86/include/asm/desc_defs.h

# 2.分页机制

代码位于：/linux-4.5.2/arch/x86/include/asm/pgtable_64_types.h

/linux-4.5.2/arch/x86/include/asm/pgtable.h

# 3.Linux物理内存管理架构

代码位于：

/linux-4.5.2/include/linux/mmzone.h

/linux-4.5.2/include/linux/mm_types.h

/linux-4.5.2/arch/x86/boot/memory.c

# 4.地址空间

代码位于：/linux-4.5.2/include/linux/mm_types.h

/linux-4.5.2/arch/x86/include/asm/page.h

# 5.伙伴系统

代码位于：/linux-4.5.2/mm/page_alloc.c

/linux-4.5.2/arch/x86/mm/init_32.c

/linux-4.5.2/mm/internal.h

# 6.slab分配器

代码位于：/linux-4.5.2/mm/slab_common.c

/linux-4.5.2/mm/slab.h

/linux-4.5.2/mm/slab.c

# 7.kmalloc

代码位于：/linux-4.5.2/mm/slab.c

# 8.vmalloc

代码位于：/linux-4.5.2/mm/vmalloc.c

# 9.memcached slab

代码位于：/memcached-1.5.3/slabs.c

/memcached-1.5.3/items.c

# 10.redis zmalloc

代码位于：/redis-3.2.9/src/zmalloc.c