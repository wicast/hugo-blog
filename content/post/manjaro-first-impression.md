---
title: manjaro上手初体验
date: 2014-12-26T20:00:03+08:00
tags:
  - Linux
  - Arch
  - Manjaro
imageurl: "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
---
### 起因
  最近又心血来潮想再搞个 arch 玩玩,windog真是越来越卡了。arch之前就玩过一次， aur 那爽快体验让我瞬间从一个ubuntu党叛变为 archer！！不过 arch 最麻烦的地方就是安装得从 cli 开始从0配置， GUI 界面还得自己搭建（，当然好处是给予用户对系统完全的控制，w酱在配置过一次之后就再也不想从cli搞了，用一机油的说法就是装一个 arch 简直和开一盘文明5一样（

  不过开源大法好，面对如此不友好的安装方式，社区自然衍生出了一些自带 GUI 的衍生版本。在这个 [列表](https://wiki.archlinux.org/index.php/Arch_Based_Distributions)中能找到很多打包的不错的发行版本，比如高度集成了KDE的[chakra](http://chakraos.org/)、专门为openbox打包的[ArchBang](http://www.archbang.org/)。

  w酱在考虑后最终选择了[manjaro](manjaro.org)。首先一个原因，不会去选择 chakra 因为一直不喜欢臃肿的KDE，而 manjaro 几乎提供了所有主流DE的版本（KDE和xfce是官方发布，其余都是有社区支持发行），可以有更多的选择。第二则是 manjaro 给每一个DE都做了一套看上去还不错的主题，没有使用 majaro 的同学可以[点此下载](https://github.com/manjaro/artwork-menda)。
<!--more-->
###### manjaro的截图
![](https://41.media.tumblr.com/79430b7be94745d63330cd60ba237c63/tumblr_nh715cZkwK1tqgztwo1_1280.png)

### 选择xfce
  尝试了xfce、MATE和openbox三个版本。w酱最后用的是xfce，为何选择xfce，主要轻量级，再配合[pytyle](https://aur.archlinux.org/packages/pytyle/)能流畅实现类似3/awesome的平铺效果（上图），平铺的好处在于提高了屏幕的利用率，提高写代码的效率，w酱之前一次用arch时候是玩的i3，虽然平铺体验是挺好但实在是太丑了，于是这里换成了xfwm4+pytyle的组合（试过在MATE下使用pytyle，但实在不如xfce下流畅），pytyle虽然有2代和3代，但不知道是什么原因死活没法生效。。而且一代的pytyle还得把依赖改成
>depends=('python2>=2.6' 'python2-xlib')

不过最后能用还真是太爽了！！！配合chrome下载一个[Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)终于实现了梦寐以求的全键盘操作！！

### 下载
xfce版官方提供了 torrent 下载
[Manjaro Community Torrents](http://sourceforge.net/projects/manjarotorrents/)
安装步骤几乎和 ubuntu 无异，比起原 版arch 省时省力不少，驱动也会自动给装上，不过w酱的电脑是intel+amd的都逗逼配置，驱动似乎并没有完全发挥显卡的性能，窗口拖动时会有明显的垂直不同步（，驱动的问题有空再整吧。。。

## 安装后的一些问题
### grub优化
  第一次进入系统是会发现 grub 没有我的win8.1给识别出来。。在官网上的[UEFI - Install Guide](https://wiki.manjaro.org/index.php?title=UEFI_-_Install_Guide)找到这两行代码（w酱是UEFI）

>sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg

可以在进入 manjaro 之后执行操作，重新生成grub配置文件，也可以在 manjaro Live CD 中把grab所处的分区挂在到某个地放（双系统应该是有windows efi的那个esp分区），上边的路径也要做修改，如果依旧没有识别出windog，安装dosfstools, efibootmgr这两个包后再尝试。

### fcitx无法启动

  装好fcitx后发现怎么按ctrl+space都不能启动。。。 google 后在arch 中文社区找到了[解决方案](http://bbs.archlinuxcn.org/viewtopic.php?pid=13921)
在 ~/.xprofile 中加入一下几行代码重启后就正常了。
```~/.xprofile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx```

## 总结
初次体验 manjaro 给我留下的印象还是不错的：用户友好、清爽养眼的界面、完全保留 arch 的所有优点。
不过 manjaro 现在还出于bate阶段，可能有各种bug，小问题还是不少，w酱用了几天偶尔碰到键盘鼠标失灵。。。而且usb键盘热插拔之后也会乱码。。。个人怀疑是udev的问题。
总之，对这次的尝鲜还是挺满意的，之后可能会一直使用 manjaro 作为自己的Linux系统作为开发环境。

**UPDATE:找到一个比vimium还给力的插件[cVim](https://chrome.google.com/webstore/detail/cvim/ihlenndgcmojhcghmfjfneahoeklbjjh)**
