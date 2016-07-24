+++
comments = true
date = "2016-07-24T18:06:56+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["Linux", "qt5"]
title = "在非KDE桌面下Qt5.7主题崩坏的解决方案"

+++

前段时间 Qt5.7 更新移除了 QGtkStyle 这个模块，直接导致了非 KDE 环境下 Qt 应用主题直接崩坏（

<!--more-->
在 ArchWiki 上找了下解决方案，发现一个叫 [qt5ct](https://www.archlinux.org/packages/?name=qt5ct) 的包可以在非 KDE 下设定 Qt 应用的主题（oxygen、breeze）。

安装好后首先在菜单栏里打开 qt5ct（这玩意是有 .desktop 文件的），咱选择的是用 breeze，字体个人喜欢用 noto。

之后在你的 `.xprofile` 里加上一句 `export QT_QPA_PLATFORMTHEME=qt5ct` 重启 X 后那些 Qt 应用就能直接用 KDE 主题辣

#### 已知问题：
ss-qt5 会崩溃，启动 ss-qt5 的时候记得去掉这个环境变量。
默认没法用暗色主题，breeze 自带的 color-scheme 和 qt5ct 不兼容，无奈花了点时间，对着 arc-dark 的颜色自己做了一份配色：https://github.com/wicast/dotfiles/tree/master/qt5ct/.config/qt5ct/colors
