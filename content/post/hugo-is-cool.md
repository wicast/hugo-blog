+++
comments = true
date = "2015-03-23T06:02:15+08:00"
draft = false
image = ""
imageurl= "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["Hugo","Golang"]
title = "Hugo is cool"

+++
换到 hugo 之后一直在修修改改，这两天边看文档边摸索总算初步整容完成。

对比 Hexo，基于 golang 编写的 Hugo 最大的优势就是非常快，官方号称能做到几秒钟内渲染 5000+ 的页面，而且 golang 本身属于编译型语言不需要安装任何 runtime 依赖。文章编辑方面一样支持 markdown 编辑。

---
### Hello Hugo

#### 安装

Arch 用户可以在 Aur 中找到做好的包。
```
yaourt -S hugo
```
<!--more-->
#### 初始化
和 Hexo 很像，使用前先要指定好 Hugo 的工作目录并初始化。
```
hugo new site /path/to/site
```
初始化后的目录如下

>$ tree 
.  
├── archetypes #md文件头部默认格式  
├── config.toml #配置文件，默认为 toml 格式，可换成 yaml/json  
├── content #文章根目录  
├── data #作用不明，官方文档也没提到  
├── layouts #渲染模板  
└── static #静态文件，css、js以及图片  

#### 主题
相比之下 Hexo 的主题大部分都是几个基础主题衍生而来，如果没有过硬的前端技术很难改出与众不同的效果 ~~咱就是前端喳喳~~ ，Hugo 的基础主题则更为丰富，w酱则使用了 Ghost 的默认主题 Casper。
```
 git clone --recursive https://github.com/spf13/hugoThemes.git themes
```
git clone 下载即可。

---
### Using Hugo
```
hugo new post/hello.md
```
执行上面这条命令，Hugo 会在 content 文件夹下新建 post 子目录，并同时生成 hello.md。建议将所有的博文都放入 post 文件夹下方便日后管理。

markdown文件头如下,默认采用toml格式，与Hexo有所区别  
这个是 Hugo：

>\+\+\+  
date = "2015-03-23T06:56:18+08:00"  
title = "2333"  
tags = []  
+++  

这个是 Hexo：

>title: "2333"  
date: 2015-03-15 20:22:37  
tags:  
\-\-\-  

区别并不大，差别在于时间日期变成了 (Date)T(Time)+TimeZone，还有就是 Hugo 的文件头一定要用对应的 wrapper 符号包起来。

- toml 使用 \+\+\+
- yaml 使用 \-\-\-
- json 则可以直接使用，因为已经用了 {}

原来 Hexo 下的文章这么小改动下就能直接用了，博文正文一样使用的 markdown 编写，不过 Hugo 还支持 RST 格式，各位有兴趣可以自己看下[官方文档](http://gohugo.io/content/front-matter/)。

#### 本地测试
开始使用前还有几点要注意的：

1. Hexo 通过把文章放在 _draft 文件夹下来表示草稿，而 Hugo 则是通过文件头的 draft 变量判断是否为草稿。
2. 而 config.toml 文件大致上和 Hexo 很像，但由于 Hugo 不自带部署工具所以不需要填写任何 repo 的地址，部署完全交给用户手动操作。
3. Hugo 需要指定主题才能正常渲染页面，否则会生成空页面。 ~~其实是因为根目录下的layout是空的~~

执行下面这条命令使 Hugo 渲染并监听 1313 端口，浏览器打开 http://localhost:1313 就能在本地调试啦！静态网页默认生成在 public 文件夹。

`hugo server --watch --theme="casper" --buildDrafts`

- 其中 watch 表示监视模板，一旦模版有改动则重新渲染
- buildDrafts 表示连同草稿一起渲染，比较特别的是被 Hugo 渲染的 Draft 文章会很明显的标记出草稿，算是一个人性化的设计
- \-\-theme="casper" 则是指定主题模板，默认 Hugo 会尝试使用 layout 文件夹下的模板，如果 layout 为空，才会从 themes 文件夹寻找指定的主题。

Hexo 的渲染生成命令是 `hexo g` 而 hugo 则只要在工作目录下运行 `hugo` 即可， `-d` 参数可以另行指定生成的目录。

如果想修改主题的话建议各位将想要使用的 theme 中的 static、layout 以 archetypes 文件夹下的东西复制到根目录下的对应文件夹，这样既可保留原始主题，同时也等同与设定了默认主题。

#### 部署
前面说了由于 Hugo 不自带部署工具，所以得先把自己之前的站点 `git clone` 下来，然后手动覆盖再 `git push` 上去，整个过程可以完全的脚本化处理，并没有特别麻烦。

### Notice when porting from Hexo
####路径
Hexo 默认的 post 路径是 http://(baseurl)/(date)/(post) ，而 Hugo 在默认情况下原封不动地吧 content 里的路径展现出来……这样对于原来使用 Disqus 这样的评论系统会造成不小的麻烦。

解决方案很简单，在 conf.toml 中加入这一行

>[permalinks]  
   post= "/:year/:month/:day/:filename"

将原来 post 路径替换成我们想要的结构，这样也免得修改 Disqus 的数据了。
#### RSS地址变动
Hugo 的 RSS 地址名称不能自己定义……而且 RSS 文件居然叫 index.xml  
就这个问题似乎还真的是无解，稍微看了眼代码似乎是写死的……

顺便也在这里再次声明一下新的 RSS 地址为 http://tnt.wicast.tk/index.xml
#### 隐藏某些单页
Hexo 的时候友情链接还是通过一个懒人 widget 插件给挂在旁边的。Hugo 下的主题似乎并没有提供类似的 widget，所以只好自己造个单页。  
执行 `hugo new links.md`  
结果一开站点就出问题了……不应该出现在 post timeline 中的友链页面一样会被渲染到主页。

读了下官网[模板渲染的一章节](http://gohugo.io/templates/overview/)，发现 Hugo 对于列表一类的页面是通过套用 `list.html`  和 `li.html` 模板生成的，而且可以设定具体路径下套用的模板。直接在放 content 下的 markdown 文件被渲染成 page 类型的页面，知道了这点就好办了。

以w酱使用的 [casper](https://github.com/vjeantet/hugo-theme-casper) 为例

1. 首先将 casper 的资源内容复制到根目录
2. 在 layout 目录下应该有 `_default` 文件夹（渲染的时候如果没有对于路径的模板则使用这个文件夹下的模板），整个文件夹复制一份改名为 `page`，将 `li.html` 和 `list.html` 里的内容清空，只留空白。
3. 此时 post timeline 应该已经是看不到 links.md 下渲染的页面了。但是打开 links 页面发现页面现实还是有些不正常。检查代码后发现 casper 的 single.html [第30行](https://github.com/vjeantet/hugo-theme-casper/blob/master/layouts/_default/single.html#L30) 写着 `class={{.Type}}`，友链的页面实际的 Type 为 `page`，但是 CSS 里没有这个叫 `page` 的类。所以强制改成 post 就发现可以正常显示了。 ~~RSS里依然会推送发po，似乎也没有有效的办法解决~~

---
##总结
和 Hexo 把一堆功能集成起来，Hugo 更注重保持本身的简洁专一，专攻静态站生成。

个人感觉 Hugo 虽然是个比较小众的博客方案，但好在官网的[文档](http://gohugo.io/overview/introduction/)比较齐全，上手成本也并不高。

还有一点比较有意思的是，作者 [spf13](https://github.com/spf13) 本人是来自 [Docker Inc.](https://www.docker.com/) 的大神，相信还有不少 Vimer 也对他的 [spf13-vim](https://github.com/spf13/spf13-vim) 项目有印象吧。

