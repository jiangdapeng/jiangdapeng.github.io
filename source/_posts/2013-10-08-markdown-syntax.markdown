---
layout: post
title: "markdown 常用语法"
date: 2013-10-08 09:44
comments: true
categories: tech
tags: [markdown, pat]
---
#前言
## 为什么我会出现在标签 pat 下
说起来，是因为，我写第一篇pat题解，用 `bundle exec rake generate` 的时候，报错了

> Liquid Exception: comparison of Array with Array failed in page

Google 了一下，有人说是“每个tag都只使用一次的时候”，这个问题就会出现。我测试了一下，还果真是如此，为了暂时解决这个问题，我只好把pat标签在这篇post里也应用一下了。

## 标题
# 这是 H1
``` 
\# 这是 H1
```
## 这是 H2
``` 
\## 这是 H2
```
### 这是 H3
```
\### 这是 H3
```
#### 这是 H4
```
\#### 这是 H4
```
## 区块引用

> 区块引用1
>
> > 区块引用2
>
> 回到引用1

> ## 这是一个标题
> 
> 1. 列表1
> 2. 列表2
> 
> 给出一些例子代码：
> 
> 	return shell_exec("echo $input | $markdown_script");

## 列表
### 无序列表
* 师叔
* 师太
* 春哥
* 马老师
* 主席
* 女王大人
* 亲王大人

### 有序列表
1. 师叔女人1号
2. 师叔女人2号
3. 师叔女人3号
4. 。。。

## 代码区块
这是普通的段落

	这是代码块（行首4个空格或者1个制表符）

## 区段元素


