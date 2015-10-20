+++
comments = true
date = "2015-09-13T23:49:07+08:00"
draft = true
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = []
title = "开学的各种折腾"

+++
开学这个星期……折腾了一堆东西，几乎快把身边的电子设备倒腾了个遍（手机没弄）……

先后折腾了 hg255d OpenWRT、Cubieboard Archlinux Arm，此外由于过于作死，把 enhanceIO 的 Write-Back 打开了，不但没加速 IO还把笔记本 Arch 的文件系统搞崩了（事后才想起来没备份）……强行重装了电脑。

#### hg255d OpenWRT
一回学校就发现……路由器直接挂了。不过本来就打算换新的固件，而且 14.09 的 ipv6 似乎也是挂的……到 OpenWRT 的官网上一搜发现官方不提供 hg255d 的预编译固件……无奈只能自己丰衣足食。

首先需要源码
```
git clone http://git.openwrt.org/15.05/openwrt.git
```
进入目录
```
cd openwrt
```
进入设置菜单（编译所需要的软件请自行解决，咱的平台是 Archlinux）
```
make menuconfigure
```