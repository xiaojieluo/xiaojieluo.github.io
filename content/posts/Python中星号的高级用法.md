---
title: "Python中星号的高级用法"
date: 2020-11-26T22:14:29+08:00
draft: false
slug: advanced-usage-of-asterisk-in-python
tags:
    - Python
---

星号，即乘法运算符，是所有程序中的常用符号。对于我们来说，仅将其用作乘法运算符就足够了。但是，如果真的想成为一名 Python 专家，则必须要掌握星号运算符的高级用法。

这篇文章将展示星号运算符的五种用法，从基础到深入，提供最容易理解的示例。

<!--more-->

## 1. 乘法或乘幂运算符

最简单的用法是将星号用作中缀表达式：

- 单个 `*` 用于乘法运算
- 两个 `*` 用于幂运算


```shell Python-shell
>>> 2*3
>>> 6

>>> 2**3
>>> 8
```

## 2. 接收不限数量的参数

如果一个函数需要更大的灵活性，或者甚至不确定要传递多少个参数，则函数不一定必须声明固定数量的参数。

```python
def print_genius(*names):
    print(type(names))
    for n in names:
        print(n)

print_genius('Elon Mask', 'Mark Zuckerberg ', 'Yang Zhou')
# <class 'tuple'>
# Elon Mask
# Mark Zuckerberg
# Yang Zhou

def top_genius(**names):
    print(type(names))
    for k, v in names.items():
        print(k, v)

top_genius(Top1="Elon Mask", Top2="Mark Zuckerberg", Top3="Yang Zhou")
# <class 'dict'>
# Top1 Elon Mask
# Top2 Mark Zuckerberg
# Top3 Yang Zhou
```

如上面的案例所示，在定义函数时，我们可以声明一个带有一个或两个星号的参数，以捕获数量不限的参数。

- 以 `*` 为前缀的参数可以将任意数量的`位置参数`捕获到 `元组(tuple)` 中
- 以 `**` 为前缀的参数可以将任意数量的`关键字参数`捕获到`数组（dict）`中

按照约定，如果无法确定其参数个数，我们将定义如下函数：

```python
def func(*args, **kw):
    pass
```

## 3. 仅限关键字参数

星号的一种非常酷的使用方法是使一个函数只能接收关键字参数。

```python
def genius(*, first_name, last_name):
    print(first_name, last_name)

# genius('Yang','Zhou')
# TypeError: genius() takes 0 positional arguments but 2 were given
genius(first_name='Yang', last_name='Zhou')
# Yang Zhou
```

如上面的示例所示，只有一个 `*` 可以限制所有一下参数必须使用关键字参数传递。
实际上，如果我们只想将一些参数限制为仅关键字，并保留一些位置参数，可以将位置参数放在 `*` 参数之前。


```python
def genius(age, *, first_name, last_name):
    print(first_name, last_name, 'is', age)

genius(28, first_name='Yang', last_name='Zhou')
# Yang Zhou is 28
```

## 4. 用作可迭代对象的解包

我们可以使用 `*` 来解压可循环的迭代变量，这将使我们的程序清晰、优雅。
如果我们要将不同的可迭代项（例如一个列表，一个元组和一个集合）组合到一个新列表中，那最好的办法是什么？

显然，我们可以用 for 循环来迭代所有项并将它们逐个添加到新列表中。

```python
A = [1, 2, 3]
B = (4, 5, 6)
C = {7, 8, 9}
L = []
for a in A:
    L.append(a)
for b in B:
    L.append(b)
for c in C:
    L.append(c)
print(L)
# [1, 2, 3, 4, 5, 6, 8, 9, 7]
```

一个更好的方法是使用列表推导式：

```python
A = [1, 2, 3]
B = (4, 5, 6)
C = {7, 8, 9}
L = [a for a in A] + [b for b in B] + [c for c in C]
print(L)
# [1, 2, 3, 4, 5, 6, 8, 9, 7]
```

我们将三个 for 循环减少为一个列表推导式，它已经够 Pythonic 了，但不一定是最简单的！

现在来看看用星号运算符重写的代码：

```python
A = [1, 2, 3]
B = (4, 5, 6)
C = {7, 8, 9}
L = [*A, *B, *C]
print(L)
# [1, 2, 3, 4, 5, 6, 8, 9, 7]
```

如上所述，我们可以使用星号做为可迭代对象的前缀来解压其变量。
顺便说一句，如果我们将`单个*` 用做 `dict` 变量前缀，则其`键`将被解压，
如果我们使用`双星号 *` 用作 `dict` 的变量前缀，则其`值`将被解压。

```python
D = {'first': 1, 'second': 2, 'third': 3}

print(*D)
# first second third

# print(**D)
# TypeError: 'first' is an invalid keyword argument for print()

print('{first},{second},{third}'.format(**D))
# 1,2,3
```

## 5. 拓展的可迭代对象解包

[PEP 3132](https://www.python.org/dev/peps/pep-3132/) 引入了这种解包语法，以使我们的代码更加优雅。、

> 这个 PEP 提案提议可迭代对象的解包语法进行修改，允许指定一个 `cache-alll` 变量名，这个变量将在已定义变量名被赋值后接收所有剩下的元素。

一个简单的示例：

```python
data = [1, 2, 3, 4, 5, 6, 7, 8]
a, *b = data
print(a)
# 1
print(b)
# [2, 3, 4, 5, 6, 7, 8]
```

## 结论

`星号(*)` 是程序中最常用的一种运算符之一。除了用作乘法运算符之外，它在 Python 中还有一些强大而有趣的用法。
熟练掌握 Python 的 星号运算符，可以帮助你写出更加优雅，更加可读，更加 `Pythonic` 的程序。

