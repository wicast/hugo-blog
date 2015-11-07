+++
comments = true
date = "2015-10-30T17:39:50+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["git","gogs"]
title = "在 Cubieboard 上部署 gogs 自建私人 gitserver"

+++

平时不怎么喜欢吧半成品的东西放到 github 上去，所以上面一直空空的……  
不过平时鼓捣自己项目的时候还是得有个 VCS 才行，零时的一个在线的私有副本还是有点需求的……

自建 gitserver方案有很多，有裸 ssh 直接建立的、还有一种方案是 gitlab 直接山寨的 github，不过目测 ruby 的脚本在咱的 arm 上不会跑得很流畅……于是选用了 golang 的 gogs 方案，编译型的语言应该能比脚本跑得快点。
<!--more-->
#### 安装
其实安装也没啥好说的，咱用的 Archlinuxarm，直接可以在 AUR 找到[软件包](https://aur.archlinux.org/packages/gogs/)自动编译，PKGBUILD 里已经有写了“armv7”支持，如果是树莓派的话 makepkg 的时候可能还需要加 `“-A”` 参数忽略硬件平台。

其他操作系统的请在[官方文档](http://gogs.io/docs/installation)寻找安装方法.

#### 配置
在 AUR 的包里已经有自带了 systemd 的 service 文件了。
```
systemctl start gogs
```
就让服务运行起来了，gogs 的服务用的是一个叫 gogs 的用户运行的，默认的用户路径是 `/srv/gogs`，配置文件也在这里。gogs 的配置文件模版放在 `/usr/share/gogs/conf 里`。

gogs 默认监听的 3000 端口，而在咱的局域网内，alarm （archlinuxarm）这个域名被 dnsmasq 自动映射到了某个内网 ip，很便利。第一次进入 gogs 的 web 页面就会看到初始化配置的界面了。

第一次配置 gogs 的时候，想把 gogs 的 repo 放到咱外挂的那个 2T 的移动硬盘，结果就碰到了文件权限的问题。移动硬盘的 owner 是 alarm ，而 gogs 的用户是 gogs 没有权限读写，如果用组的方式管理又感觉很不方便……  
找了下资料发现 unix 类的文件系统其实还有一种叫 ACL 的机制，可以让单独某个用户拥有不属于自己也不在组里文件的权限。

cd 到移动硬盘根，创建一个加 gogs 的目录，然后
```
setfacl -m "u:gogs:rwx" gogs
```
这样 ls -la 的时候就能看见文件权限指示上多了个“+”，这个就是 acl 了。
```
drwxrwxr-x+ 1 alarm        alarm           8 Oct 29 21:51 gogs
```
用 getfacl 命令可以获取目录的 ACL 信息
```
getfacl gogs
```

之后在 gogs 设置时就不会出错辣！

想让 gogs 开机自动启动的话也很简单，用过 systemd 的都知道。
```
systemctl enable gogs
```

使用起来就和github几乎一样～
![](https://img.vim-cn.com/f7/15b07c71d4838e32f4358d62722792dfbcf4a5.png)
享受吧～

