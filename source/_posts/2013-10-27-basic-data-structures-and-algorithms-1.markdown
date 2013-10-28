---
layout: post
title: "基础数据结构与算法——排序"
date: 2013-10-27 22:39
comments: true
categories: tech
tags: [c++,algorithm]
---
最近几天在重温基础的数据结构和算法，比如基础的排序算法，以及动态规划的应用，也慢慢的在博客上写一个基础的系列吧，作为自己温习的记录。

## 排序算法

### 插入排序
虽然插入排序的时间复杂度期望是O（n^2)，但是具有实现简单，属于***原地排序***，并且是***稳定排序***的特点。之所以将其叫做插入排序，是因为，每一轮操作都是将一个***待排序***的数插入到一个***已经排好序***的序列中，过程可以想象将一张扑克牌插入到已经按顺序摆好的扑克牌中，代码如下：
``` c++
void insertion_sort(int A[], int low , int high)
{
	for(int i=low+1; i<=high;++i)
	{
		int x = A[i];  // 当前需要排序的数，它之前的数都已经排好序了
		int j = i-1;
		while(j >=low && A[j] > x)
		{
			A[j+1] = A[j];
			j--;
		}
		A[j+1] = x;  // 将 x 放置在正确的位置
	}
}
```
<!--more-->
### 堆排序
这里的堆排序，特指利用二叉堆进行排序操作，在讲排序前，得先把堆的构建、取最大（最小值）等操作进行介绍。二叉堆实际上是在数组上实现的一个树形结构，而窍门就在于，通过将根元素放置在下标为***`1`***的位置，元素的父节点和左右孩子节点的位置都可以通过简单的运算得到。

``` c++
// 节点 i 的父节点下标 i/2
inline int PARENT(int i)
{
	return i >> 1;
}

// 左孩子 2*i
inline int LEFT(int i)
{
	return i << 1;
}

// 右孩子 2*i + 1
inline int RIGHT(int i)
{
	return (i << 1) + 1;
}

inline void SWAP(int& a, int& b)
{
	int t = a;
	a = b;
	b = t;
}

// 这个纯粹了方便查看一个堆的情况
void print_heap(int A[],int n)
{
	cout << A[1];
	for(int i=2;i<=n;i++)
		cout << " " << A[i];
	cout << endl;
}

// 大顶堆，使得以A[i]为根的子树 是个合法的大顶堆
void max_heapify(int A[],int i,int n)
{
	int left = LEFT(i);
	int right = RIGHT(i);
	int next = i;
	// 选出左右孩子中最大的元素
	if(left <=n && A[left] > A[next]) next = left;
	if(right <=n && A[right] > A[next]) next = right;
	if(next != i)
	{
		SWAP(A[next],A[i]);
		max_heapify(A,next,n); // 递归的往下操作
	}
}

void build_heap(int A[], int n)
{
	// A[i+1],A[i+2],...,A[n]都是叶子节点，只需要从非叶子节点开始
	// 这个操作严格的时间复杂度是O(n)
	for(int i=n/2;i>0;--i)
	{
		max_heapify(A,i,n);
	}
}

void heap_sort(int A[], int n)
{
	// 注意 A 中的有效元素应该从下标为1开始
	// 整个的复杂度是O(N*logN)
	build_heap(A,n); // 建立最大堆, O(n)
	for(int i=n;i>1;--i)
	{
		SWAP(A[1],A[i]);
		max_heapify(A,1,i-1); // O(logN)
	}
}

```


### 快速排序
快速排序的核心思想是分治，如何分就成了关键问题。快速排序的想法是:
> 先找到序列中的某个数`x`，然后将所有小于或等于`x`的数都放到`x`前面，大于`x`的数都放在它后面，然后再分别对前后两个部分进行排序。这个过程被称为`选主元`。选的过程也将数据进行了一次划分。
 
主元的选择的好坏对算法的性能有影响，原因就在于，如果主元的值合适的话，前后两个子问题的规模可以迅速地降低。例如，如果每次主元都恰好是中间值，那么子问题的规模就以指数形式降低，`n/2,	n/4, ..., n/2^k`。一种常见的选择主元的方式如下：

``` c++
// 选择最后一个数做主元
int partition(int A[], int low, int high)
{
	int x = A[high];
	int i = low -1;
	for(int j = low;j<high;++j)
	{
		// 找到所有小于或等于 x的数，交换到前面
		if(A[j] <= x)
		{
			i++;
			SWAP(A[i],A[j]);
		}
	}
	SWAP(A[i+1],A[high]); // after this , A[i+1] = x
	return i+1;
}

void quick_sort(int A[], int low ,int high)
{
	if(low < high)
	{
		int p = partition(A,low,high);
		quick_sort(A,low,p-1);		// 对前半部分排序
		quick_sort(A,p+1,high);		// 对后半部分排序
	}
}

```

如果数据的顺序是随机的，那么这种方式的平均性能并没有什么问题。但是对某些特定顺序的数据，这种方式的快速排序，性能会处于最坏情况，也就是说，时间复杂度是`O（n^2)`。比如说，数组已经排好序了，那么每次划分后的子问题规模是线性减小的（由`n -> n-1 -> n-2  -> ... -> 1`），最终整体的复杂度也就是`O(n^2)`。为了避免这种问题，有一个稍微改进的选主元的方式：
> 每次先选择序列中的三个数，然后选择这三个数的中间那个数作为主元。或者是采用随机函数，随机选择某个数作为主元

这种方式几乎可以避免非常坏的情况出现，除非是针对算法特意构造出来的序列。下面给出三选一的一种实现：
``` c++
// 选择三个数的中间数作为主元
int median_partition(int A[], int low, int high)
{
	int a = A[low];
	int b = A[high];
	int c = A[(low+high)/2];
	int x = (a <=b && b<= c || a >= b && b >= c)?b:(b<= a && a <= c || c <= a && a <= b)?a:c;
 	// 后面的代码都跟前一种实现相同
	int i = low -1;
	for(int j = low;j<high;++j)
	{
		if(A[j] <= x)
		{
			i++;
			SWAP(A[i],A[j]);
		}
	}
	SWAP(A[i+1],A[high]); // after this , A[i+1] = x
	return i+1;
}
```

### 归并排序&others
归并排序核心思想也是`分治`，它与快排不同的地方在与，你可以选择以最优的方式来划分子问题（在二归并中，你可以每次都从`n/2`处划分），因此归并排序在最坏情况下时间复杂度也是`O(n*logn)`。但是它也有较明显的不足之处：归并排序不是`原地排序`，主要是在合并的过程中需要利用`O(n)`的额外空间。以下是归并排序的伪代码：
``` c++
void merge_sort(A, low, high)
{
	if(low < high)
	{
		middle = (low + high)/2;
		merge_sort(A,low,middle);
		merge_sort(A,middle+1,high);
		merge(A,low,middle,high);
	}
}
```

递归的代码写起来确实非常简洁，但是注意到中间调用了一个`merge`函数，这个函数并不是递归的，`merge`的思路也很简单，因为需要合并的两个序列都是已经排好序的，那么每次取两个序列头部的小者填入正确的位置即可。伪代码如下：
``` c++
void merge(A,low,middle,high)
{
	n1 = middle - low + 1; // 前一部分元素的个数
	n2 = high - middle;	   // 后一部分元素的个数
	创建数组 left[n1+1] 以及 right[n2+1];
	for i = 0 to n1 - 1
		left[i] = A[low+i];
	for i = 0 to n2 - 1
		right[i] = A[middle + 1 + i];
	left[n1] = INT_MAX;		// 作为哨兵
	right[n2] = INT_MAX;	
	i = 0;
	j = 0;
	for k = low to high
		if(left[i] <= right[j])
			A[k] = left[i];
			i++;
		else 
			A[k] = right[j];
			j++;
}
```

归并的思想还是非常不错的。特别是在需要排序的数非常之多，以至于都无法一次载入内存的时候，就可以利用归并的思想，先将数据分块，将每一块都排序后再逐个合并在一起。

另外还有其他的排序算法，如冒泡排序，好像大学学到的第一个排序算法就是这个？希尔排序，对插入排序的改进，以及`不是基于比较的排序算法`，如`count sort`、`radix sort`、`bucket sort`等等，后面几种下一次再说。
