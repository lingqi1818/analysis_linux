# 本章涉及内核代码对应文件

# 1.read调用

代码位于：/linux-4.5.2/fs/read_write.c

# 2.vfs结构

代码位于：/linux-4.5.2/fs/ext4/file.c

# 3.write调用

代码位于：/linux-4.5.2/fs/read_write.c

# 4.page cache

代码位于：/linux-4.5.2/mm/filemap.c

# 5.DirectIO

代码位于：/linux-4.5.2/mm/filemap.c

其中ext4_direct_IO位于：/linux-4.5.2/fs/ext4/inode.c

# 6.Block层

代码位于：/linux-4.5.2/block/blk-core.c

# 7.scsi层

代码位于：/linux-4.5.2/drivers/scsi/scsi_lib.c

#8.I/O调度

代码位于：/linux-4.5.2/block/elevator.c

# 9.多队列

代码位于：/linux-4.5.2/block/blk-mq.c

# 10.epoll

代码位于：/linux-4.5.2/fs/eventpoll.c

# 11.redis epoll

代码位于：/redis-3.2.9/src/ae_epoll.c

# 12.nginx aio

代码位于：/nginx-1.12.1/src/event/modules/ngx_epoll_module.c

# 13.tail源码

代码位于：http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/tail.c

# 14.mmap

代码位于：/linux-4.5.2/mm/mmap.c

# 15.sendfile

代码位于：/linux-4.5.2/fs/read_write.c

# 16.mongodb

相关代码位于：/mongodb-src-r3.6.0/src/mongo/db/storage/mmap_v1/mmap_posix.cpp

# 17.kafka

相关代码位于：

core/src/main/scala/kafka/network/SocketServer.scala

kafka/clients/src/main/java/org/apache/kafka/common/network/KafkaChannel.java

kafka/clients/src/main/java/org/apache/kafka/common/network/TransportLayer.java

kafka/clients/src/main/java/org/apache/kafka/common/network/PlaintextTransportLayer.java

kafka/clients/src/main/java/org/apache/kafka/common/network/SslTransportLayer.java