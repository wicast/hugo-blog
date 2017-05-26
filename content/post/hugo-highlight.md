+++
comments = true
date = "2015-04-06T13:09:03+08:00"
draft = true
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["Hugo","Golang"]
title = "为hugo添加代码高亮"

+++
在官方文档里给出了两种方法，一种是通过 Pygments 本地预渲染后再套用 css ，而另一种则是借助外部 js 在客户端渲染。  
http://gohugo.io/extras/highlighting/

<!--more-->

个人选择了借助外部的 highlight.js 库进行渲染，好处就是不需要在本机上多装什么软件了。启用方式也很简单，只要让所有页面的 head 部分包含以下三行代码即可。

```html
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.5/styles/docco.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.5/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
```

一般 hugo 的主题都些在 layouts/partials/header.html 里面。

更多高亮样式可以直接从 cdnjs 里预先配置好的 css 中挑选。  
https://cdnjs.com/libraries/highlight.js
