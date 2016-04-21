+++
comments = true
date = "2015-05-04T17:27:23+08:00"
draft = false
image = ""
imageurl = "https://41.media.tumblr.com/c52fec0a8ad4c1ddb6d93870290619d7/tumblr_nmcb5higeE1tqgztwo3_1280.jpg"
tags = ["Golang","编程语言"]
title = "初入坑golang，感觉良好"

+++
#### ~~先吐槽个几句~~
去年年底的时候想学一门新的 web 语言，于是拿起了时下火的不得了的 [node.js](https://nodejs.org)。然而越是深入就越感觉自己陷入泥潭…… [Callback Hell](http://callbackhell.com/)、[async()](https://github.com/caolan/async)、[Promise](https://www.promisejs.org/)，光是想让 js 将几件事按照 1、2、3、4……这样的顺序执行代码就有这么几种框架可选……  
然而就 Promise 而言又有 Promise/A 和 Promise/A+ 这样分裂的版本…… Promise 本身是 [ES6 标准](http://www.ecma-international.org/publications/standards/Ecma-262.html)所规定的。然而在 ES6 之前就有一堆第三方的 Promise 实现，比如 [Q](https://github.com/kriskowal/q) 啊……[BlueBird](https://github.com/petkaantonov/bluebird) 啊等等……  
然而上面说的一大堆其实目的只有一个……让代码调用能有序地执行……
<!--more-->
此外咱还借机读了一点 [Libuv](http://docs.libuv.org/en/v1.x/) 的文档……然而真是太高估自己了……实力不够根本没法很自如的掌握其用法……学习过程突出一个受苦……
### 转投阵营
node 的坑太大咱能力太差无法驾驭……于是最终选择了由 Google 主导的新语言 [Golang](http://golang.org/)。而个人对 Golang 的体验总结为一个字——爽！

### 第一印象——简洁，清晰
这是 Golang 所推崇的语言风格，先来看段代码

```go
package main

import "fmt"

var i, j int = 1, 2

func main() {
   fmt.Println("Arch is the best!")
   var c, python, java = true, false, "no!"
   fmt.Println(i, j, c, python, java)
}
```
这就是 Golang 的语法，Golang 的语法给人一种 Python 的感觉，然而她语言特性更接近 C /C艹 的特点——静态、指针、结构体等等。

**值得注意的是 golang 的所有类型声明是放在最后面的。**

推荐的学习材料除了官方的 [GoTour](https://tour.golang.org) 之外还有 [「go-fundamental-programming」](https://github.com/Unknwon/go-fundamental-programming/) 和 [「build-web-application-with-golang」](https://github.com/astaxie/build-web-application-with-golang)。里面有详尽的 golang 语法教程。


## 优势特色
### 面向对象——一切皆类型
在函数式编程语言中，“函数是一等公民”是函数式编程的中心思想，然而在 golang 中，我们的一等公民是类型，即由
```go
type TypeName TypeStruct
```
这样语句定义的类型，顺带一提的是函数也是可以被定义为类型，所以 golang 也可以玩 lambda 表达式

Golang 虽然继承了许多 C/C艹 的设计思想，但她的面向对象却始终围绕着类型展开，与 Java/c艹/py 之流的传统风格差异不小。
#### 定义类型
来看点代码，假设现在定义一个基类叫 Human。

```go
type Human struct{
    Name string
    Age int
}
```
这样 Human 的基本信息就定义好了，接下来随便初始化一个 Human 实例
```go
jojo := Human{"JOJO", 21}
```
#### 添加方法
接下来就是 golang 好玩的地方了。回想一下你在使用 py/java/C艹 的时候都是在定义 Class 中就定义好方法的。而 golang 的做法则是现有类型后再"钩"上方法。  
为某个类型添加方法：
```go
func (this Human) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.")
}
```
对比一下普通的 function 定义方式：

```go
func FuncName (arg argType) （ReturnValue ReutrnType） {
    //do someting
}
```
唯一的区别就在在 func 关键词和 FuncName 之间多了一個 Receiver，这个 Receiver 指明了这个函数要挂在哪一种类型的后面。

调用风格和普通的 OOP 没有两样
```go
jojo.Who()
```
需要注意的是，如果定义的 Receive 是一个指针类型，那么调用这个方法可以直接修改这个类型中的值，否则只是一个对拷贝的操作。

#### 继承
struct 里面申明的东西都叫字段，而字段分为两种：显式和隐式。
struct 也可以嵌套，这就是 golang 中继承的实现方法。
```go
type Vampire struct{
    Human //Human 被嵌套在 vampire 里面，而且属于匿名字段
    KillCounter int
}
```
这时候挂在 Human 后面的 Who() 方法一样对 Vampire 有效。

我们再对 Vampire 单独添加一个方法叫 KillPeople()：
```go
func (this *Vampire) KillPeople() {
    this.KillCounter++
}
```
这个方法就是对被调用对象的本体进行操作了，会改变具体的值。

#### 方法重载
要覆盖父类的方法也很简单，写一个同名的方法，把对应的 Receiver 改掉，so easy。
```go
func (this Vampire) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.I've killed", this.KillCounter, "people.")
}
```

最后完整代码如下：
```go
package main

import (
    "fmt"
)

type Character interface {
    Who()
}

/*--------------------------------------*/
type Human struct {
    Name string
    Age  int
}

func (this Human) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.")
}

/*-------------------------------------*/
type Vampire struct {
    Human
    KillCounter int
}

func (this *Vampire) KillPeople() {
    this.KillCounter++
}

func (this Vampire) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.I've killed", this.KillCounter, "people.")
}

/*--------------------------------------*/
func main() {
    jojo := Human{"JOJO", 21}
    dio := Vampire{Human{"Dio", 23}, 0}

    jojo.Who()

    dio.KillPeople()
    dio.Who()
    fmt.Println(dio)
}
```
输出结果：
![](https://40.media.tumblr.com/8c7a997241559a562d78cc774e611000/tumblr_nnw0ecIsGA1tqgztwo1_540.png)

个人比较喜欢这种”钩“在类型后的方法，比较灵活，组织也方便。
在 Java 中，子类如果要扩展父类所没有的方法时，需要先定义一套 interface……子类 implement 后再由去实现……极其繁琐。
#### 私有公有
在 golang 中并没有 class 这样的概念，所以也没有复杂的字段公有私有控制机制。golang 以包为单位区分公私有，所有大写开头的的都是可导出量，小写的就只能在包内访问。

* * *
有关 golang 面向对象更详细的介绍在上面的学习资料中也包括了，有兴趣的自己可以去看看。


### interface实现伪动态
首先一点……这个 interface 和 Java 里面那个 interface 完全不是一个概念……当初学的时候咱脑子怎么也转不过来……看了好久才理解。

一切皆类型，interface 也是一种特殊的类型，定义一个 interface 只要写出里面包含了那几种方法即可，不需要管方法的 receiver，也不需要知道这个方法有没有在代码的其他地方被实现。  
之前看到一个比较好玩的说法，叫：“接吻需申明”，咱倒是是觉得蛮贴切的（2333333

定义一个 interface：
```go
type Character interface {
    Who()
}
```
再初始化一个 Character 类型的变量，并把拥有 Who() 这个方法的 jojo 放到这个 avata 里面。
```go
var avata Character
avata = jojo
```
这样，调用的时候只要对 avata 调用 Who() 就能直接使用 jojo 的 Who()，而换成 dio 也一样能调用成功。  
在面对不同类型的 Who() 方法，只要最后的函数定义是一样的，只需通过一个通用的 interface 就可以很方便地调用。  
此外，想同时操作多个不同的变量的方法，可以通过 make() 创建一个 slice，通过迭代方式操作。
```go
characters := make([]Character, 2)
characters[0], characters[1] = jojo, dio

for _, v := range characters {
    v.Who()
}
```

完整代码如下：
```go
package main

import (
    "fmt"
)

type Character interface {
    Who()
}


/*--------------------------------------*/
type Human struct {
    Name string
    Age  int
}

func (this Human) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.")
}

/*-------------------------------------*/
type Vampire struct {
    Human
    KillCounter int
}

func (this *Vampire) KillPeople() {
    this.KillCounter++
}

func (this Vampire) Who() {
    fmt.Println("This is", this.Name, "who is", this.Age, "years old.I've killed", this.KillCounter, "people.")
}

/*--------------------------------------*/
func main() {
    jojo := Human{"JOJO", 21}
    dio := Vampire{Human{"Dio", 23}, 0}

    dio.KillPeople()

    var avata Character
    avata = jojo
    avata.Who()
    avata = dio
    avata.Who()
    characters := make([]Character, 2)
    characters[0], characters[1] = jojo, dio

    for _, v := range characters {
        v.Who()
    }
}
```
从结构上来看，interface 处在调用的最上游，类型存储数据，最后则是具体实现方法函数。

### goroutines并发模型——阻塞利用
说道并发(concurrency)，又不得不扯扯 node.js，要知道为啥 node.js 最近这么火，其中一个原因就是基于异步事件驱动的 I/O 模型，即使在单线程下(目前 node.js 写多线程并不是非常好用，也没啥必要)也能提供非常高的并发能力。然而事件驱动嘛……终究需要一个 event loop 去循环事件，而被放入 event loop 的事件都需要指定好一个回调(callback)函数以便事件发生后执行。**于是 CallBack Hell 就这么来了……**

基于 Callback 非常不利于编写和维护代码，所以在一些别的语言中又兴起了一种叫协程(coroutines)的东西，协程比起线程、进程更加轻量，调度策略也是由语言 runtime 维护，而不是由操作系统，不过各种语言的实现不一，我们这里主要介绍 golang 的实现。
##### 使用goroutine

我们先来看下面一段代码：
```go
package main

import (
    "fmt"
)

func hi() {
    fmt.Println("Arch is the best.")
}

func main() {
    go hi()
    fmt.Println("Arch 大法好！")
}
```
运行结果：
![](https://40.media.tumblr.com/9f32c551910da87721996b34e9e58a55/tumblr_nnw0ecIsGA1tqgztwo2_1280.png)

其中 go 这个关键词的意思就是让函数送入一个 goroutine 运行，goroutine 的[运作本质](http://www.zhihu.com/question/20862617#answer-6525538)我们先不去细纠，其实是和线程类似的东西。

然而我们也看见了，被送入 goroutine 的 hi() 函数并没有每次都运行，只有第一次输出了信息。  
这是为什么呢？在解释这个问题之前，我们需要再了解一个叫 channel 的东西，这是一个和 goroutine 配套使用的东西，负责在不同的 goroutines 以及主线程之间传递数据。
##### channel的使用

```go
package main

import (
    "fmt"
)

func hi(a chan string) {
    fmt.Println(<-a)
}

func main() {
    c := make(chan string)
    go hi(c)
    word := "Arch is the best!"
    c <- word //or `c <- "Arch is the best"`
    fmt.Println("Arch 大法好！")
}
```
以上代码，这时候再执行就每次都能输出两句话了。  
我们来一句句分析，首先要使用 channel 依旧需要 make 一个出来。
```go
c := make(chan string)
```
然后则是把 hi() 函数放入一个 goroutine，并且将之前 make 的 channel c 作为参数送入函数，注意这个时候 hi() 需要接受一个为 string 类型的 chan~~nel~~ a
```go
func hi(a chan string) {
    fmt.Println(<-a)
}
```
此外 Println() 的内容也变成了 "<-a"，这个 "<-" 是 channel 的操作方式，又是个新玩意，解释一下他的语义：**取出右边的值，传递到左边，当"<-"左边是空的时候就直接输出数据。**
```go
word := "Arch is the best!"
c <- word  //or c <- "Arch is the best"
```
这一步就是在主线程中通过 c 这个 channel 送入要打印的字符串。

而除了传递数据以外，channel 其实还起到了另一个非常重要的作用——阻塞。

###### channel的阻塞作用
你会想，既然 channel 能够传数据，那么我能不能这么用呢？

```go
package main

import (
    "fmt"
)

func main() {
    c := make(chan string)
    c <- "Arch is the best"
    fmt.Println("Arch 大法好！")
    fmt.Println(<-c)
}
```
然而你会看到这样的报错……
![](https://40.media.tumblr.com/300465b33a1d6337a20d45ec2690e236/tumblr_nnw3p0EhUE1tqgztwo1_1280.png)

对 deadlock——死锁，前面也说了，channel 的另一个作用是阻塞，阻塞的就是当前使用这个 channel 的主线程/协程。当这段代码执行到
```go
c <- "Arch is the best"
```
channel 会把 main 主线程给阻塞了，直到她的另一头的输出端处于可写的状态才会释放阻塞。  
**默认情况下 channel 类型是不具有存储功能的，她只有连通两头一写一读的作用。**

这里第一个 channel 已经把主线程阻塞了……永远也执行不到输出端可写。也就是：
```go
fmt.Println(<-c)
```
回过头看 goroutine，再结合最初的 goroutine 不执行的情况，不难得出一个结论：**goroutine 是一种惰性的、优先级低的任务，只有在别的 goroutine 或主线程被阻塞的时候才会执行。**  
注意这里的用词是”阻塞“而不是”忙碌“，阻塞是指线程/协程被一些外界因素拖累导致无法执行代码必须先等待，而不是忙着执行代码以至于无法顾及其他线程/协程。

知道了这个特性，那么在最开始头一次使用 goroutine 会输出 "Arch is the best!" 字样，而后面几次都未出现，这个问题也可以解释了——第一次调 "fmt" 包的时候应该有什么东西需缓存导致主线程意外地阻塞了。

让我们来尝试一下通过 channel 以为的方法阻塞主线程：
```go
package main

import (
    "fmt"
    "time"
)

func arch() {
    fmt.Println("Arch is the best!")
}

func main() {
    go arch()
    fmt.Println("Arch 大法好！")
    time.Sleep(time.Microsecond * 1)
}
```
最蠢的 Sleep 就能达到阻塞的效果。
##### 总结
不难发现，比起传统的进程线程，goroutine 不需要管理锁的问题，通过阻塞线程来保证原本需要互斥的资源的安全性，同时又高效智能地调度了那些闲着的任务。比起异步事件驱动要容易上手好多。  
有关 goroutine 更多高阶的使用方法推荐读一下这篇博文：[Go并发模式：管道和取消](http://air.googol.im/2014/03/15/go-concurrency-patterns-pipelines-and-cancellation.html)

### 跨平台支持
现在许多脚本语言有一个优势——跨平台，依靠对不同平台开发 runtime 来达到跨平台支持。 golang 是编译型的语言，需要依靠编译器支持交叉编译才行。然而好消息是 golang 的官方编译器对 arm、x86 以及 x86_64 构架的操作系统支持的非常好，除了主流的 windoge、Linux 和  OSX 以外还支持像 plan 9、dragonfly 这样的冷门操作系统……

###### 开启交叉编译
在 Archlinux 官方打包的 go 官方编译器 ~~go 还有一个以 GCC 为 backend 的编译器，先不管他了~~，编译时只开启了 Linux 的支持……所以咱在 AUR 上打包了两个启用了更多交叉编译选项的包：[go-cross-major-platforms](https://aur.archlinux.org/packages/go-cross-major-platforms/)启用了 windoge 和 OSX 的支持以及 [go-cross-all-platforms](https://aur.archlinux.org/packages/go-cross-all-platforms/) 开起了所有平台支持。~~源码下载请自行解决~~

别的平台，OSX 在安装时加一个参数即可调整支持。~~Ubuntu 这种平台的情况就不清楚了，乃们自己想办法吧，反正官方是支持很全的~~
```
brew install go --cross-compile-all
```

_ _ _

说些题外话。就个人认为，脚本语言只是把编译这个过程延后到了运行，像 node.js、pypy以及未来的 PHP7 这些动用了 JIT 这种预编译的技术，倒不如一开始就编译好来的更高效，还能有更深度的指令优化。Android 5.0 开始甚至动用了 AOT 技术直接把字节码编译成指令存起来……连 JIT 都跳过了……  
如果编译器能够很好地支持增量编译，而且支持交叉编译的平台够多，那么其实选择编译型的语言做夸平台更方便，发行的时候对方不需要安装任何 runtime ，直接跑二进制即可。


## 缺点
说了这么多 golang 的优点，就我现在调查下来的情况，其实这玩意还是有那么几个问题的。
### 无法动态加载库
golang 虽然支持倒入 C 语言的包——通过内置的 "cgo" 包，然而编译始终是静态的，也就是说最后编译出来的只有可执行文件，而无法将你的包制作成 .so .dll 这样可以动态加载的库。

不过 .a 这样的静态链接库还是可以做的，又时项目内的包也会很多，每次有一点点的改动都要全部编译一遍也很费时间，先把包编译成库可以节约很多时间，具体怎么操作后面再说。
### 包管理不完善——需借助第三方
来说一下 golang 工程的构建方法。
一般一个工程目录解构长这个样:
```
$ tree .
.
├── bin
├── pkg
└── src
    ├── config
    │   └── config.go
    └── test
        └── main.go
```
src 很好懂不解释，bin 则是放置最后编译出的可执行文件的目录;而 pkg 则是放置 .a 这样的静态链接库的文件夹。在 GOPATH 下看到的目录解构也是这样的。

GOPATH 是用于第三方包的文件夹，通过 `go get ` 这样的命令获取，或者通过自行下载源码 `go install PACKAGE_NAME` 也会被安装到 GOPATH 下。

然而用过 node.js npm 的同学都知道，每个项目下调用的第三方库最好是互相独立，而且最好指定版本。

然而 golang 官方没有提供靠谱的包管理工具，别说是独立库，连版本指定都无法做到(需要 get 后手动 checkout 再重新 install)……所以咱推荐使用 [gvp](https://github.com/pote/gvp) 和 [gpm](https://github.com/pote/gpm) 作为包管理软件，gvp 用于设置当前临时的 GOPATH，而 gpm 则类似 node.js 的 npm，通过 Godeps 文件设置第三方库和版本。

###### 安装gpm和gvp

OSX 的 brew 又有打包，archlinux 在 AUR 上也有：[gvp](https://aur.archlinux.org/packages/gvp/) 和 [go-gpm](https://aur.archlinux.org/packages/go-gpm/)

gpm 还有一堆 [Plugins](https://github.com/pote/gpm#plugins) 在 AUR 上暂时无人打包，回头有空咱来弄一下好了……

通过 gvp 的设置，我们可以使用

```
go install config
```
将 config.go 编译成 config.a 静态库，在 pkg 文件夹下能找到。不过，咱暂时没有找到只通过 .a 静态库就能使用第三方库的方法，目前必须要看得到源代码才能使用。


### 良好的调试工具
目前的情况……golang 的调试还需要借助 gdb……不过 golang 1.5 似乎会有些[动作](https://docs.google.com/document/d/1FP5apqzBgr7ahCCgFO-yoVhk4YZrNIDNf9RybngBc14/pub)。


## 推荐学习材料
目前这些就是咱对 golang 接触下来的全部心得了，项目什么的暂时都没开坑……各种特性咱也是刚刚熟悉的。

初心者入坑的推荐还是[「go-fundamental-programming」](https://github.com/Unknwon/go-fundamental-programming/) 和 [「build-web-application-with-golang」](https://github.com/astaxie/build-web-application-with-golang)

goroutine 的学习推荐：[Go并发模式：管道和取消](http://air.googol.im/2014/03/15/go-concurrency-patterns-pipelines-and-cancellation.html)