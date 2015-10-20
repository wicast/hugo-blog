---
title: KeePass 全平台同步方案及浏览器支持
date: 2015-01-26T02:21:30+08:00
tags:
  - KeePass
  - Sync
  - WebDav
  - 密码
imageurl: "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
---
续上一篇博文的提到 KeePass **全平台同步**和**浏览器支持** 的问题。  
在这篇博文咱会给出个人比较满意的一组方案。

- - -

### 浏览器支持
先来说浏览器的，其实 KeePass 原本就自带了一个 Global Auto-type 的功能，但是实际这个功能个人使用下来并不舒服。。。。首先 Linux 下得绑定快捷键才能触发 Global Auto-type，其次在我的 xfce4 下面这个功能完全不能在浏览器下工作QAQ

功能不满足不了咱门就得上插件了。KeePass 插件的安装也是特别简单，下载了 .plgx 格式的插件文件直接扔到 KeePass 所在的文件夹就行，下次启动 KeePass 之后会自动编译插件。 ~~Linux用户得修改下权限才能通过编译233333，不过大部分插件在 AUR 能找到。~~

#### [keepasshttp](https://github.com/pfn/keepasshttp)
这是个由第三方开发的一个 KeePass 浏览器辅助工具，需要在 KeePass 和浏览器两边分别装上插件才能使用。
<!--more-->
##### 安装

浏览器端有 [Chrome](https://chrome.google.com/webstore/detail/chromeipass/ompiailgknfdndiefoaoiligalphfdae?hl=en) 和 [FireFox](https://github.com/pfn/passifox/) 版可用，Chrome 版的功能似乎多一些。

两边安装完插件后还需要一次连接一次才能运行
点击 Chrome 插件栏的图标就能看见。

![](https://40.media.tumblr.com/108aeb77985123d12e24a3a7688a08d1/tumblr_niqyi89b5C1tqgztwo1_400.jpg)

Connect 时保持 KeePass 处于解锁状态，点下蓝色按钮 KeePass 会自动弹出一个要求输入一个 Key Name 的输入框，名字随意，这个是用于区分当前的 Chrome/Firefox 插件的一个标识而已。

链接成功之后当前密码库的根目录下生成一个 KeePassHttp Settings 的 Entry，看名字就知道是干啥了，之前填写的 Key Name 也在这个 Entry 的 Advance 标签页下找到。

##### 使用
有了 keepasshttp 咱们就能像 LastPass 那样自动检测密码表单啦！！！

![KeePass本体还会弹出提示](https://40.media.tumblr.com/edecb1d85934686cf2ad68c35a354470/tumblr_niqzk5uTxa1tqgztwo1_1280.png)

上图就是就是通过 keepasshttp 自动填写的登陆表单www ~~密码当然是随机生成的啦~~，第一次会提示你是否允许提取数据。

keepasshttp 也支持自动添加新数据到密码库，新数据会添加到一个叫 KeePassHttp Passwords 的文件夹里。

![](https://40.media.tumblr.com/2787685a6ba193f7df6f499de8d1cce7/tumblr_nir0ojtkep1tqgztwo1_400.jpg)

######  tips： 在 KeePass Entry 的 URL部分建议修改成 somesite.com 这样的形式，可以一下子匹配到不同的三级域名。但是对于拥有同样用户名密码的网站（比如 steampowered.com 和 steamcommunity.com ）只能通过在另个一 Entry 里索引这个用户名和密码来达到数据的统一。

- - -

### 全平台同步
w酱弃用 LastPass 很大一个原因是是因为手机上得收费才能用，KeePass 在 Android 平台上对应的客户端 [Keepass2Android](https://play.google.com/store/apps/details?id=keepass2android.keepass2android&hl=zh_CN) 可以算得上时功能极其强大，最关键的在于，这玩意支持通过 WebDav 打开密码库的功能。而 KeePass 本体也是支持 WebDav 协议的，所以同步也有了着落，找个支持 WebDav 的网盘就行了。

##### WabDav是个啥？
其实看上去名字高大上，实际不过是基于 HTTP 协议的一种文件访问读写的协议。
http://zh.wikipedia.org/zh/WebDAV

大部分国外网盘都会提供 WebDav 协议的访问支持，不过由于我朝特殊的网络环境，导致那些优秀的外国网盘服务在天朝非死即残。。。 ~~想让度娘支持WebDav这协议真是想多了~~

好在国内总会有几个求异的公司。 [坚果云](https://jianguoyun.com)就是一家。之前用的 [box.net](https://box.net) 的 WebDav 服务来同步数据库，别提有多慢了。。。


要注意的是不同提供商的 WebDav 登陆密码是不同的，坚果云用的是生成一个 token 来作为的密码，而 box.net 则是直接用了帐号的密码。

##### 部署 WebDav 云端
下面以坚果云为例：

坚果云要用 WebDav 需要先创建一个**同步文件夹里**。这点很重要，当时搞了半天才发现个人文件夹无法用 WebDav 访问。。。

我创建了一个叫 keepass 的文件夹，然后把密码库扔到这个文件夹里面。

![](https://41.media.tumblr.com/362ea93e2e780763b4ce24034ae93f9e/tumblr_nir353j34L1tqgztwo1_500.png)

下一步就是到帐户设置里面的安全选项，看到最下面有个第三方授权

![](https://41.media.tumblr.com/2696bd79421e06ea1975ad9d1a064a93/tumblr_nir3fflZWH1tqgztwo1_540.png)

地址和帐户都写着了，添加一个新的应用就能生成一个 token 了，这个 token 就是咱们接下来要用来访问 WebDav 的密码。

##### 手机端部署同步
先来部署手机端，Keepass2Android 的打开文件里选中 HTTPS(WebDav)

![除了WebDav还能看到其他类型的协议](https://41.media.tumblr.com/214c46c67436649b06c3c12617443f82/tumblr_nir5g4Z5BL1tqgztwo1_540.png)

URL 里输入 https://dav.jianguoyun.com/dav/keepass/NewDatebase.kdbx
最后的 keepass/NewDatebase.kdbx 路径就是之前在同步文件夹建立并上传的密码库文件。

点击打开输入坚果云的帐号和 token，顺利的话密码库就会缓存到你的手机。输入你的密码库主密码解锁吧。

手机端的 KeePass2Android 好用的一个地方在于如果在浏览器点击分享能直接把当前 URL 送到 KeePass2Android 进行查询。

每次打开数据库前 KeePass2Android 都会先尝试下载远端文件，打开后同步云端和手机的密码库。如果手机下载失败则会尝试使用本地缓存先打开。

##### PC端部署同步
前面说了，KeePass 原生支持 WebDav 协议。但其实想用 WebDav 来同步云端密码库还是要考虑一些问题的。。。

KeePass 本体对通过 URL（也就是网络）打开的文件并没有 KeePasss2Android 那样的缓存机制，每次的读写都会通过网络，而且在断网的时候是无法打开之前打开过的 URL，因为本地没有缓存

解决方法其实也很简单，把密码库下载到本地然后通过 Synchronize 功能与远端文件同步。Synchronize 的行为是同时将两个主密钥相同的密码库进行合并，如果数据有冲突 KeePass 也能自动提示处理，Synchronize 结束后本地的密码库和云端的密码库应该是保持一致的。

![](https://40.media.tumblr.com/9163846db5d79fdad5faeaa1a2d5de74/tumblr_nirpx6NtPJ1tqgztwo1_540.png)

最后一个问题就是如何自动进行同步了，KeePass2Android 全都管理好了这些，而 KeePass 还需要自己设置。利用 KeePass 的 Triggers 功能即可实现自动同步了。

首先新建一个 Trigger，名字随便写。

![](https://41.media.tumblr.com/b74c2ce001c06d6bef45660df24b4c0f/tumblr_nirsggZD9e1tqgztwo3_1280.png)

在 Events 里选择 Closing database file (before saving)，别选 Closing database file (after saving)，会造成 Trigger 的无限循环。。。。

![](https://40.media.tumblr.com/465d1cbf14aae198d0ae7c7d3ba5763e/tumblr_nirsggZD9e1tqgztwo1_1280.png)

Condition 一栏填写 Database has unsaved changes，这样做使得每次只有在密码库自动锁定时（我设定了3分钟如果不做什么就锁定密码库），如果密码库有改动未保存，才会触发同步。毕竟同步一次时间也是比较长，而且坚果云对 WebDav API 的访问是有限制的。

![](https://41.media.tumblr.com/c438b64df1726f2c5e59f9c8a9247a32/tumblr_nirsn6I8PX1tqgztwo1_540.png)

最后在 Action 里选择 Synchronize active database with a file/URL ，URL 与用户名部分就和之前 KeePass2Android 一样写。至于密码部分，由于 KeePass 的 Triggers 的设置是直接保存在 KeePass 设置文件里的,**如果你的硬盘未加密的话任何人都能找到你的** **WebDav** **密码**，有不安全的成分。不过由于坚果云 WebDav 不会建立文件夹索引，只有知道云端文件路径才能读写到文件。再加上我的坚果云里面暂时只有 KeePass 密码库，而密码库又是加密的。所以即使泄露了 WebDav 密码姑且也是安全的，如果不嫌麻烦可以考虑每次同步时手动输入密码233。

![](https://40.media.tumblr.com/8735470d31ac72a0379c9d8b929ab3fe/tumblr_nirsggZD9e1tqgztwo4_1280.png)

并不建议使用坚果云的客户端下载到本地后直接打开密码库，由于这样打开的密码库 KeePass 不会执行 Synchronize 行为，会在你的同步服务里产生一堆冲突的历史文件，w酱以前直接用 DropBox 就发现了这个问题。。。

Linux 用户还需要注意两点：一个是由于 mono 的 bugs，在填写 Trigger 的时候最好每填一格保存并退出 KeePass 一次，因为 KeePass 此时很容易崩溃。。。
还有一点则是需要手动为 mono 导入证书，否则会出现 Https 握手失败。
运行一下这条命令即可
```
mozroots --import --ask-remove

```

### 结尾
KeePass 同步以及浏览器的问题就讨论完了，其实这还只是 KeePass 最为基础的功能，如果深入挖掘会发现 KeePass 提供的功能（包括插件）实在是太强大
前一阵逛 [AUR](https://aur.archlinux.org) 的时候偶然发现了一个叫 [KeeAgent](https://aur.archlinux.org/packages/keepass-plugin-keeagent/) 的插件，摸索了一下发现玩意简直逆天了。。。下一篇就着重讲解一下 KeeAgent的用法好了。

就单论功能而言，只要找到正确的姿势，KeePass 完全就是完爆 LastPass 和 1Password！！！
