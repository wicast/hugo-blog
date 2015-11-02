+++
comments = true
date = "2015-08-09T02:30:05+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["SSD","Linux","Tips"]
title = "使用小容量 SSD 加速系统"

+++
之前也是因为看到依云学姐的这篇 [使用 bcache 自制「混合硬盘」](http://lilydjwg.is-programmer.com/2015/5/11/self-made-sshd-with-bcache.92025.html)，才想到本子上的 24G SSD 可以这么被利用起来，Manjaro 的时候用了 LVM 把 SSD 分区和 HDD 分区给连了起来，然而除了多 24G 容量以外 SSD 的速度优势一点都没有感受到……最后还因为 SSD 坏块的缘故把系统弄挂了。
<!--more-->
说起来咱这块固态盘可是身经百战了呢！最早被拿来当 windows 的系统分区 ~~大作死~~，最后容量满了机器直接一开机就蓝屏；后来用了 Intel Repid storage 结果反而没啥提速也是蓝屏不断；之后闲置了很久直到用了 Manjaro，结果用了一会就发觉 24G 空间太窄了……最近的一次也就是 LVM 了。

依云学姐用的 bcache，等咱把 bcache-tools 装好了才发现这玩意需要从一开始就配置好加速分区，不能在现有的系统分区上建……这时候咱已经配好 Arch 了……  
虽然有个叫 block 的工具能将现有的分区转换成 bcache 的格式，不过仔细研究了下这个工具的原理感觉相当的没谱——它转化分区的原理就是向目标分区的前一个分区夺取一小部分空间来写到目标分区的头部，相当的危险呢……咱 Arch 的系统分区就在 /dev/sdb2 上面，sdb1 就是 windows 保留分区……当然不能随便乱动啊。

学姐提到的另外几个方案 dm-cache 和 flashcache 配置起来似乎也是相当的麻烦……PASS。

不过在 Archlinux Wiki 上翻了一通之后发现还有个叫 [EnhanceIO](https://wiki.archlinux.org/index.php/EnhanceIO) 的方案是学姐没提到的，而且这个方案比 bcache 好在可以不用专门整顿分区！！

使用方法非常简单，怎么用 [wiki](https://wiki.archlinux.org/index.php/EnhanceIO) 都写的一清二楚，不多解释。由于 SSD 有过几次坏块的历史……缓存方案使用的是默认的 Write Through，没有用更快的 Write Back，不过加速效果还是非常明显的，软件启动的速度、桌面载入明显要比以前快不少，已经达到咱理想中的期望值了。

不过 EnhenceIO 这玩意在 Arch 上的新内核有些相性不佳……在开启加速重启后会出现 /proc 文件创建失败的问题导致缓存配置读取不到……但是并不影响加速系统的效果，而且还是有几率正常创建的……github 上也看到了和咱一样问题的 Archer 报了 issue.

此外 wiki 中还写了怎么在内核启动的时候就加载模块，咱比较懒惰，而且稍微启动慢点也无所谓，Linux 启动本来就挺快了。