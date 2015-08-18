---
title: KeeAgent——SSH private key 同步管理利器
date: 2015-01-30T14:58:34+08:00
tags:
  - KeePass
  - ssh
  - KeeAgent
imageurl: "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
---
上回在「[KeePass 全平台同步方案及浏览器支持](http://tnt.wicast.tk/2015/01/26/keepass-sync-and-browser-support/)」里说道了 KeePass 这玩意儿了，这回咱就在这里就做一个详细的介绍。

[SSH private key](https://wiki.archlinux.org/index.php/SSH_Keys_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29) 相信在看本文的各位一定是非常熟悉了，不多解释。
以前使用 SSH key 的时候就遇到不少过让w酱非常不爽的地方，总结为以下几点：

1. 对于每一个不同域名都得在 Config 文件里写好配置，每次为某台主机或网站生成一对密钥都得写一次 Config。
2. Private key 要求输入一个 short phrase 来保证私钥的安全性，但是每次使用时候输入却很烦，如果是 short phrase 是空的又不安全。虽然我们可以用 KeePass 记录密码，但还是觉得每次复制粘帖很麻烦。
3. 同步备份问题，首先一点 Private key 绝对不能丢！！丢了的话，重新弄一对 Key 去重置了原来的 Key 也够麻烦的了。
4. 没有一种统一管理方式，虽然是放在 .ssh 文件夹下，但并没有工具化管理。SSH private key 本身也可以看成是一种特殊的密码，碰到密码，咱就想用 KeePass 统一管理起来

<!--more-->

前一坐逛 AUR 时无意中发现了 [KeeAgent](http://lechnology.com/software/keeagent/) 这个软件，几乎完美地解决了上面几个困扰w酱很久的问题。KeeAgent 则是一个 基于 KeePass 的插件（有关 KeePass 的详细介绍看「[密码那点事——密码管理的可靠方案](http://tnt.wicast.tk/2015/01/25/KeePass-introduce/)」和「[KeePass 全平台同步方案及浏览器支持](http://tnt.wicast.tk/2015/01/26/keepass-sync-and-browser-support/)」。

#### 工作原理
Linux 下有个叫 SSH-agent，对应 windows 下的 putty 也有个叫 pageant 软件。在用 KeeAgent 之前，其实咱也对 SSH-agent 这类软件毫不知情。。。
而 SSH-agent 在 [Arch wiki](https://wiki.archlinux.org/index.php/SSH_Keys_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29#ssh-agent) 的解释已经很清楚了：
>如果您的私钥使用密码短语来加密了的话，每一次使用 SSH 密钥对进行登录的时候，您都必须输入正确的密码短语。
而 SSH agent 程序能够将您的已解密的私钥缓存起来，在需要的时候提供给您的 SSH 客户端。这样子，您就只需要将私钥加入 SSH agent 缓存的时候输入一次密码短语就可以了。这为您经常使用 SSH 连接提供了不少便利。

而 KeeAgent 所起到的作用与 SSH-agent 完全一样，只是 KeeAgent 驻于 KeePass 之中，而 SSH-agent 则属于 openSSH 软件包下（pageant 则属于 putty 软件包），使用方法几乎是一样的。

#### 安装
arch 用户请直接从 AUR 安装 [keepass-plugin-keeagent](https://aur.archlinux.org/packages/keepass-plugin-keeagent/) 。其他OS用户请查看[官方教程](http://lechnology.com/software/keeagent/installation/)，使用 GNOME Keyring 的用户请注意一些额外修改。

安装后重启 KeePass 可以看见 KeePass 开始编译插件，如果编译失败可以试试去修改插件文件的权限,成功后一个能在 option 下看见 KeeAgent 的设置了。

![](https://41.media.tumblr.com/2514975b021ee2260a78cb751b23dfe0/tumblr_niy4za8VIT1tqgztwo1_400.png)

#### 前期准备
如果是 Mono 下使用的 KeePass，由于某些奇怪的bug，在使用 KeeAgent 之前先得安装一下 putty 套件，而且不能安装比较旧的版本，否则在将带 shrot phrase 的 ppk(putty private key)文件转换成 openSSH 格式时会报错。
咱用的是 AUR 里的 [putty-svn](https://aur.archlinux.org/packages/putty-svn/) 。

**之后将需要通过 KeeAgent 管理的 SSH private key，转换为 openSSH 和 putty 格式各一份，这一步很重要，由于 Mono 3.x 的 bug 会导致 KeeAgent 无法正常使用 openSSH 格式的 key ，而 KeeAgent 本身支持 openSSH 和 putty 格式，即使是 Linux/OSX 下也能使用 ppk 格式的key。**

#### 使用详解

1. 首先咱们先创建一个 SSH group。
2. 为每一个 SSH private key 创建一个 entry (Edit > Add Entry…)
![](https://40.media.tumblr.com/9dd02497d3e1d677570c77bf191dfe6c/tumblr_niy4za8VIT1tqgztwo2_1280.png)

3. 打开 entry，名字随意，密码填写创建 SSH key 时的short phrase。
![](http://lechnology.com/wp-content/uploads/2014/04/dl21display.png)

4. 之后在 advance 标签里，点击 attach 选中你的 SSH private key，**建议将 ppk 和 openssh 格式的 key 都导入**，注意此时导入到 KeePass 密码库的 key 是一个附件（属于 KeePass 内建功能），而不是引用了本地资源，本地的那个 private key 已经可以删了免除后患。
![](http://lechnology.com/wp-content/uploads/2014/04/dl20display.png)

5. 切换到 entry 的 KeeAgent 标签页，这个标签页只有安装了 KeeAgent 才有。勾选 Entry has SSH key,紧跟着的后两个选项建议只勾选第二个，第一个只有常用的 SSH key 才勾选上。Location 选择 Attachment，KeeAgent 会自动检测当前 entry 下有什么附件,**Mono 用户请选择 ppk，w酱 Manjaro Linux、Mono 3.12.0,测试下来能够添加 openSSH 格式的 key，但是想移除这个 Key 的时候就会发生严重崩溃.....**
![](http://lechnology.com/wp-content/uploads/2014/04/dl22display.png)

6. 点击 OK > 保存 KeePass ，此时就 SSH key 就以附件形式保存在 KeePass 密码库中了，保存 SSH key 的 entry 不需要填写 Name、URL 字段，留空即可。
7. 使用 key 的方法也很简单，点击 option 下面的 KeeAgent 打开 SSH key 的管理界面，已经加载的 Key 都在这里能看见。
![](http://lechnology.com/wp-content/uploads/2014/04/dl24display.png)
![](http://lechnology.com/wp-content/uploads/2014/04/dl25display.png)

8. 要加载 key 也很简单，对着设置好的 entry 右键能看到一个 Load Entry in KeyAgent(截图是旧版的)
![](http://lechnology.com/wp-content/uploads/2014/04/dl23display.png)

9. 加载了 key 咱们就能那个网站直接测试了，w酱先用了自己的 Cubieboard 做了试验，实测下来 SSH key 顺利加载，并通过验证登陆成功wwww，SSH key 带了short phrase，但中间不需有任何步骤输入，唯一需要打密码的地方就是解锁 KeePass。这样一来 SSH key 这种特殊的密码也能用 KeePass 来管理。。
![](https://41.media.tumblr.com/b6ee5548c4b5c39b344477618baa8ded/tumblr_niy8o9gSQd1tqgztwo1_1280.png)

#### 已知问题
Windows 版的 KeeAgent 可以说是比较完美地代替了 pageant 的功能，唯一需要注意的是，使用 git 时请将 git 所调用的 ssh 二进制换成 plink.exe，否则不会将密钥查询发送给 KeeAgent。据说这个需要手动设置 ssh 的问题已经在 beta 版解决了。

而非 Windows 就有可能遇到以下一些问题。

1. KeeAgent必须设置成 Client 模式才能工作。
2. openSSH 格式的 Key 加载后如果移除会出现崩溃，这个问题很严重，出现崩溃后即使 Kill 光了与 Mono 相关的所以进程依然会出问题。只有注销 or 重启才能解决问题。所以同一份 key 得放 ppk 格式的 key 一份，而 openSSH 格式则是方便以后转换用的。
3. 千万别点 Remove all！！！会发生和②一样的问题。

以上是咱在 Manjaro Linux（Arch based），Mono 3.12.0 测试的结果，虽然官方推荐使用 Mono 2.8，但实际测试下来 3.x 并无问题，只要使用时注意一下即可。

还有更多问题请直接到官方的 [Troubleshooting](http://lechnology.com/software/keeagent/troubleshooting/) 查找。

#### 安利三部曲结尾

自从用了 KeeAgent 之后，咱的 .ssh 文件夹里一个 SSH key 都没有，只有自动生成的 known_hosts。常用的 key 设置成自动加载，每次 ctrl+alt+K 呼出 KeePass 解锁，一键 push/ssh login 不需要输入多余的字符，这感觉太爽。过几分钟 KeePass 自动上锁卸载 Key，只要你的 KeePass 够安全别人完全无法获取你的 Key。

得益于 KeePass 优秀的扩展能力，使得功能和灵活度都大大强于 LastPass 这一类商业化的密码管理工具。希望以后能接触到更多 KeePass 牛×的用法
