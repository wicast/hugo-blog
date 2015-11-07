+++
comments = true
date = "2015-11-07T19:23:32+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["git"]
title = "安利一个git辅助神器——tig"

+++
最早在用 windows 的时候还是用的 sourcetree 做git 管理，虽然那家伙很慢但还算挺好用的……

换到了 Linux 之后发现没有 Linux 版的 sourcetree…  

不过在尝试了 zsh+oh-my-zsh 之后发现大部分的命令都有非常棒自动补全，唯一有问题的是想浏览 commit log 很不方便，git 自带的 `git log` 加一堆参数才能看到咱想要的信息……  
而 pacman 在安装完 git 时提示可以在装一个 tk 包让 gitk 命令工作.试了下发现功能倒是咱想要的，不过不仅界面丑的可以……而且还不不是终端程序……
<!--more-->
在使用 Linux 的期间，那些 curses/ncurses 的程序可以说让咱眼前一亮，~~谁说终端程序用户体验差的！！~~，搜索了下发现有个叫 [tig](https://github.com/jonas/tig) 的神奇软件.名字也很有意思，反写的 git.

arch 官方还打了包，说明这软件热度不低.装了一用发现尼玛这就是咱理想中的 git 工具啊！

官方截图：
![](http://jonas.nitro.dk/tig/screenshots/main-view-split.png)

来数数优点

- 与终端完美结合，一个 `tig` 命令就可以快速启动，比那些 soursetree、gitk 高到不知道哪里去了
- log 信息量大 commit log、diff一个视图里就全部浏览
- branch 的走向简洁明了
- Vim 党的胜利…vim 风格的光标移动按键
- ~~逼格MAX~~

#### 基本操作
- h：帮助菜单
- j/k：上下移动光标
- J/K：查看 diff 的时候移动 commit
- enter：查看光标选中的详细信息
- q：退出
- r：查看 refs 目录，也就是那些 branch/tag/stash
  - 此时 C 可以切换 branch/tag/stash
- Ctrl+d/Ctrl+u：上下翻页

此外还有许多启动参数可用，个人用的最多的是 `--all`，可以把所有 branch/tag/stash 列在一个视图里，相当于 github 的 network 里看到的.

不过不知道是咱用的默认设置还是软件设计就那样，如果新增加的文件没有 add 在 tig 是看不到 Unstaged changes 的，虽然 gitk 也试这样.

**总之这软件咱给满分好评！**