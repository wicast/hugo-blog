---
title: 눈_눈解决文泉驿微米黑在 Arch 上使用 Chrome 时棒文显示错位的问题
date: 2015-02-13T19:50:42+08:00
tags: ["Arch","字体","Chromium"]
imageurl: "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
---
~~兵长脸分割线~~  
눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈 눈\_눈

换到 Arch 下使用 Chrome 的时候始终有个问题，韩文的显示始终会堆叠在一块，之前并没有在意因为咱压根用不到韩文,但实际上发现某些颜文字显示也受到了影响……比如兵长脸눈\_눈

而且这个问题仅在 Chromium/Chrome 出现……
<!--more-->
![兵长脸各种……](https://40.media.tumblr.com/d8e22d73287d0760c1e45e888bc2bc11/tumblr_njpqghLwNH1tqgztwo2_540.png)

![韩文都叠起来了orz](https://40.media.tumblr.com/dc2274c5f09d1e4a36c2c9e35332b0ca/tumblr_njpqghLwNH1tqgztwo1_1280.png)

---
在搜索一番后在 [Chromium issue](https://code.google.com/p/chromium/issues/detail?id=233851) 和 [Debian Bug report logs](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=714641) 找到了相关资料。

按照这个 Bug report 的说法原因似乎是由于使用了旧版的 FontForge 导致的问题。~~w酱也看不懂字体设计的那些术语 orz，具体问题咱也不清楚。~~

Chromium 的开发者 Bungeman 给出了一个 Patch 版的 .ttc 文件，Ubuntu 和 Debian 早已将这个 Patch 合并到了文泉驿微米黑的官方仓库。Arch 的官方仓库由于上游不做出更新所以不会将第三方 Patch 合并，于是w酱自制了一个 PKGBUILD，AUR上叫 [wqy-microhei-kr-patched](https://aur.archlinux.org/packages/wqy-microhei-kr-patched/)。
