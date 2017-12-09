# 本章涉及内核代码对应文件

# 1.chroot

代码位于：/linux-4.5.2/fs/open.c

# 2.namespace

代码位于：/linux-4.5.2/include/linux/nsproxy.h

/linux-4.5.2/kernel/nsproxy.c

# 3.cgroup

代码位于：/linux-4.5.2/include/linux/cgroup-defs.h

/linux-4.5.2/kernel/cgroup.c

# 4.docker

docker涉及的模块代码分别位于：

moby->https://github.com/moby/moby.git

containerd->https://github.com/containerd/containerd.git

runc->https://github.com/opencontainers/runc.git