---
layout: post
title: "一分钟搞定搜索提示——freebase初体验"
date: 2014-02-17 19:58
comments: true
categories: tech
tags: [freebase, search, entity]
---

不相信？看完这篇文章，不管你信不信，反正我是信了！

搜索提示是什么东西，相信大家都用过google或者百度或者其他搜索引擎，当你在搜索框中敲入关键字的时候，通常会有一个搜索词推荐列表，如在google中搜索`freebase`：

![](http://blog-imgs.qiniudn.com/google.JPG)

这个东西真的能在一分钟内搞定？我的回答是“差不多吧”。所谓差不多吧，实际上就是还有点差距。差距在哪里就等你自己做出来慢慢去比较。下面正式开始实现了，新建一个index.html文件，内容如下：

``` html

<!DOCTYPE html>
<html>
    <head>
        <title> search suggest </title>
        <link type="text/css" rel="stylesheet" href="https://www.gstatic.com/freebase/suggest/4_2/suggest.min.css" />
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/freebase/suggest/4_2/suggest.min.js"></script>
        <script type="text/javascript">
        $(function() {
          $("#search").suggest({
          key: 'your-api-key-of-freebase',
          lang:'zh'});
        });
        </script>
    </head>
    
    <body>
    <input type="text" id="search" placeholder="search"> </input>
    </body>

</html>    
    
```

好了，一切准备就绪了，请用你最喜爱的浏览器打开这个文件，在出现的搜索框里输入一些关键字试试，就比如`freebase`吧，如果你还不知道这是个什么。现在你相信了我说的没有？

当然，这都是用的别人的现成的东西构建的，算不上什么真本事。但是，你也可能听到过另外一句话，"不要重复造轮子”，有些时候就应该采用拿来主义，把他人的东西纳为己用，这是对别人成果的肯定！所以我今天想在这里推荐的就是别人做好的东西，做的好东西，那就是——**freebase**。刚才所做的只是一个基于`freebase`的`jquery插件`，叫做[`freebase search widget`](https://developers.google.com/freebase/v1/search-widget)。

`freebase`是`google knowledge graph`的基础，通俗来说，它是一堆事实的网络集合。它‘知道’`神偷奶爸`是一部动画电影，哪个公司发行的，哪年上映的，还知道这部电影的另外一个名字叫做`卑鄙的我`。在这里，存储的不再只是纯粹的字符串，这些字符串代表了某个本体，具有一定的属性。更详细的介绍可以参见freebase[官网](http://www.freebase.com/)。

今天这个作为一个探索freebase的开始，后续我将继续深入了解freebase及其它所代表的新一代基于知识的搜索引擎。