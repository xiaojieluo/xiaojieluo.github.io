---
title: "通过实例学习python的fstring"
date: 2020-11-14T10:01:33+08:00
draft: false
slug: learn-python's-fstring-through-examples
tags:
    - Python
---

## 1. 什么是 Python 的 F-String

在 Python 的历史中，字符串格式已经发展了很久， 在 Python 3.6 之前，如果想要格式化字符串，可以用 `%` 操作符或者 `string.Template` 模块，随后出现了 `str.format` 方法，并为语言中添加了一种更灵活，更健壮的格式化字符串的方法。

<!--more-->

带 `%` 的旧字符串格式：

```python python-shell

>>> msg = 'Hello World'
>>> 'msg: %s' % msg

'msg: Hello World'

```

使用 `str.format`:

```python python-shell
>>> msg = 'Hello World'
>>> 'msg: {}'.format(msg)

'msg: Hello World'
```

为了进一步简化格式，Eric Smith 在 2015 年提出了 [PEP 498 -- Literal String Interpolation](https://www.python.org/dev/peps/pep-0498/)

PEP 498 提出了这种新的格式化字符串方法，它是 `str.format` 的一种简单易用的替换方法。唯一需要做的就是在字符串开头添加 `f` 或者 `F` 字符。

使用 `f-strings` :

```python python-shell

>>> msg = 'hello world'
>>> f'msg: {msg}'

'msg: hello world'

```

就是这样，不需要使用 `str.format` 或者`%`，但是，`f-string` 不能完全代替 `str.format`，在下面的文章中，我会展示几个不适用 `f-string` 的示例。

## 2. 使用 Python 进行基本的字符串格式化

如前一节所述，使用 `f-string` 格式化字符串非常简单，唯一的要求是为其提供有效的表达式。`f-string` 可以用大写的 `F`开头，并且可以与原始字符串结合使用，但是，不能将它与 `b''` 或者 `u''` 混合使用。

![image.png](https://i.loli.net/2020/11/14/tPJqyNTKCu31rpg.png)

```python python-shell
>>> book = "The dog guide"
>>> num_pages = 124

>>> f"The book {book} has {num_pages} pages"
'The book The dog guide has 124 pages'

>>> F"The book {book} has {num_pages} pages"
'The book The dog guide has 124 pages'

>>> print(Fr"The book {book} has {num_pages} pages\n")
The book The dog guide has 124 pages\n

>>> print(FR"The book {book} has {num_pages} pages\n")
The book The dog guide has 124 pages\n

>>> print(f"The book {book} has {num_pages} pages\n")
The book The dog guide has 124 pages

```

差不多就是这样，在下一节中，会列举几个不适用于 `f-string` 的示例。

## 3. f-string 的局限性

尽管 `f-string` 非常方便，但是它不能完全替代 `str.format` 。 `f-string` 在表达式的上下文获取变量值。根据 [PEP 498](https://miguendes.me/73-examples-to-help-you-master-pythons-f-strings#https://www.python.org/dev/peps/pep-0498/)的约定，这意味着表达式可以完全访问局部和全局变量，如果 `{ <expr> }` 中使用的表达式无法求值，则 python 解释器将引发异常。

```python python-shell

>>> f"{name}"

---------------------------------------------------------------------------
NameError                                 Traceback (most recent call last)
<ipython-input-1-f0acc441190f> in <module>
----> 1 f"{name}"

NameError: name 'name' is not defined

```

这对于 `str.format` 来说不是问题，因为你可以定义模板字符串，然后调用 `.format` 来传递上下文

```python python-shell
>>> s = "{name}"
>>> s.format(name="Python")
'Python'

>>> print(s)
{name}
```

另一个限制是不能在 f-string 中使用内联注释。

```python python-shell

>>> f"My name is {name #name}!"

  File "<ipython-input-37-0ae1738dd871>", line 1

    f"My name is {name #name}!"
    ^

SyntaxError: f-string expression part cannot include '#'

```

## 4. 如何格式化表达式

如果不想定义变量，则可以在花括号内使用表达式，Python 将在运行时计算出结果。

```python python-shell
>>> f"4 * 4 is {4 * 4}"
'4 * 4 is 16'
```

或者也可以这样...

```python python-shell

>>> n = 4
>>> f"4 * 4 = {n * n}"

'4 * 4 is 16'

```

## 5. 使用 F-Strings 调试代码

f-string 最常见的用法之一就是调试。在之前，很多人都是用 `hello = 42; f"hello={hello}"`来进行代码调试, 但是这样非常繁琐。现在，Python 3.6 带来了新的功能，可以将表达式重写成 `hello = 42; f"{hello=}"`，Python 将自动显示 `hello = 42`，下面的示例使用一个函数对此进行了说明，其原理是相同的。

```python python-shell
>>> def magic_number():
        ...:    return 42
        ...:
>>> f"{magic_number() = }"
'magic_number() = 42'
```

## 6. 格式化不同基数的整数

![image.png](https://i.loli.net/2020/11/15/BZ41hUEODclL7qk.png)

f-string 还允许以不同的格式显示数字。例如，可以使用 `b` 选项将 int 显示为二进制而不进行转换。

```python python-shell

>>> f'{7:b}'

'111'

```

总之，可以使用 f-string 格式化。

* `int` 转 `binary`(二进制)
* `int` 转 `hex`(十六进制)
* `int` 转 `octal`(八进制)
* `int` 转 `HEX`(所有的字符都是大写)

下面的示例使用填充功能和基础数字格式来创建一个表，该表显示了整数格式化成其他进制后的对应数据。

```python python-shell
>>> bases = {
       "b": "bin",
       "o": "oct",
       "x": "hex",
       "X": "HEX",
       "d": "decimal"
}
>>> for n in range(1, 21):
     ...:     for base, desc in bases.items():
     ...:         print(f"{n:5{base}}", end=' ')
     ...:     print()

    1     1     1     1     1
   10     2     2     2     2
   11     3     3     3     3
  100     4     4     4     4
  101     5     5     5     5
  110     6     6     6     6
  111     7     7     7     7
 1000    10     8     8     8
 1001    11     9     9     9
 1010    12     a     A    10
 1011    13     b     B    11
 1100    14     c     C    12
 1101    15     d     D    13
 1110    16     e     E    14
 1111    17     f     F    15
10000    20    10    10    16
10001    21    11    11    17
10010    22    12    12    18
10011    23    13    13    19
10100    24    14    14    20
```

## 7. 使用 F-Strings 输出对象信息

你可以用 f-string 打印自定义对象，在默认情况下，将对象传给 f-string 实例中，它将显示 `__str__` 方法返回的内容。但是，也可以使用[显式转换标志](https://www.python.org/dev/peps/pep-3101/#explicit-conversion-flag)来显示 `__repr__` 。

``` python
!r - 使用 repr() 将值转换成字符串
!s - 使用 str() 将值转换成字符串
```

```python python-shell

>>> class Color(object):

        def __init__(self, r: float = 255, g: float = 255, b: float = 255):
            self.r = r
            self.g = g
            self.b = b

        def __str__(self) -> str:
            return 'A RGB color.'

        def __repr__(self) -> str:
            return f"Color(r={self.r}, g = {self.g}, b = {self.b})"

>>> c = Color(r=123, g=32, b=255)

# When no option is passed, the __str__ result is printed

>>> f"{c}"

'A RGB color'

# When 'obj!r' is used, the __repr__ output is print

>>> f"{c!r}"

'Color(r=123, g=32, b=255)'

# Some as the default

>>> f"{c!s}"

'A RGB Color'

```

Python 还允许我们通过 `__format__` 方法[按类型控制格式](https://www.python.org/dev/peps/pep-3101/#controlling-formatting-on-a-per-type-basis)。

```python python-shell
>>> class Color(object):
    def __init__(self, r: float = 255, g: float = 255, b: float = 255):
        self.r = r
        self.g = g
        self.b = b

    def __str__(self) -> str:
        return 'A RGB Color'

    def __repr__(self) -> str:
        return f"Color(r={self.r}, g={self.g}, b={self.b})"

    def __format__(self, format_spec: str) -> str:
        if not format_spec or format_spec == 's':
            return str(self)

        if format_spec == 'r':
            return repr(self)

        if format_spec == 'v':
            return f"Color(r={self.r}, g={self.g}, b={self.b}) - A nice RGB thing"

        if format_spec == 'vv':
            return (
                f"Color(r={self.r}, g={self.g}, b={self.b})"
                f"- A more verbose nice RGB thing."
            )

        if format_spec == 'vvv':
            return (
                f"Color(r={self.r}, g={self.g}, b={self.b})"
                f"- A SUPER verbose nice RGB thing."
            )

        raise ValueError(
            f"Unknow format code '{format_spec}'""for object of type 'Color'"
        )

>>> c = Color(r=123, b=32, g=255)

>>> f'{c:v}'
'Color(r=123, g=32, b=255) - A nice RGB thing.'

>>> f'{c:vv}'
'Color(r=123, g=32, b=255) - A more verbose nice RGB thing.'

>>> f'{c:vvv}'
'Color(r=123, g=32, b=255) - A SUPER verbose nice RGB thing.'

>>> f'{c}'
'A RGB color'

>>> f'{c:s}'
'A RGB color'

>>> f'{c:r}'
'Color(r=123, g=32, b=255)'

>>> f'{c:j}'
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-20-1c0ee8dd74be> in <module>
----> 1 f'{c:j}'

<ipython-input-15-985c4992e957> in __format__(self, format_spec)
     29                 f"- A SUPER verbose nice RGB thing."
     30             )
---> 31         raise ValueError(
     32             f"Unknown format code '{format_spec}' " "for object of type 'Color'"
     33         )

ValueError: Unknown format code 'j' for object of type 'Color'

```

最后，还有一个选项可以转义非 ASCII 字符，有关信息可以查阅[docs.python.org/3/library/functions.html#as..](https://docs.python.org/3/library/functions.html#ascii)

```python python-shell

>>> utf_str = "Áeiöu"

>>> f"{utf_str!a}"

"'\\xc1ei\\xf6u'"

```

## 8. 在 F-Strings 中设置 float 精度

f-string 允许使用 str.format 格式的浮点数精度表示法，为此，可以在表达式后添加一个`:`，和带后缀f的小数点数。

例如，可以将浮点数四舍五入到小数点后两位，然后按如下格式打印变量：

```python python-shell
>>> num = 3.1415926

>>> f'num round to 2 decimal palaces = {num:.2f}'
'num rounded to 2 decimal palces = 3.14'
```

如果未指定任何精度，则 float 将使用全精度

```python python-shell

>>> print(f'{num}')

3.1415926

```

## 9. 将数字格式化成百分比

Python3.6 引入的 f-string 将数字格式化成百分比非常方便。规则与浮点数精度格式相似，不同之处在于后缀将 `f` 换成 `%`。它将数字乘以 100 并以固定格式显示，后面跟一个 `%`， 并且可以指定精度。

```python python-shell
>>> total = 87

>>> true_pops = 34

>>> perc = true_pops / total

>>> perc
0.39080459770114945

>>> f'Percentage of true positive: {perc:.%}'
'Percentage of true positive: 39.080460%'

>>> f"Percentage of true positive: {perc:.2%}"
'Percentage of true positive: 39.08%'
```

## 10. 使用 F-Strings 来对齐输出字符串

可以使用 `<` 或者 `>` 来对齐字符串。

![image.png](https://i.loli.net/2020/11/15/NL8laOgUxquf7pj.png)

```python python-shell

>>> greetings = 'Hello'

>>> f"She says {greetings:>10}"

'She says          Hello'

# 向右对齐，即在左边增加 10 个字符

>>> f"{greetings:>10}"

'     hello'

# 向左对齐，即在右边增加 10 个字符

>>> f"{greetings:<10}"

'hello     '

# 可以省略 `<` ， 默认向左对齐

>>> f"{greetings:10}"

'hello     '

```

![image.png](https://i.loli.net/2020/11/15/NQm5rlfRo3aFIAp.png)

```python python-shell
>>> a = '1'

>>> b = '21'

>>> c = '321'

>>> d = '4321'

>>> print("\n".join((f"{a:>10}", f"{b:>10}", f"{c:>10}", f"{d:>10}")))
         1
        21
       321
      4321
```

## 11. 转义字符串

如果要显示用大括号括起来的变量名而不是显示其值，可以使用双大括号 `{{ <expr> }}` 对齐进行转义

```python python-shell

>>> hello = 'world'

>>> f'{{hello}} = {hello}'

'{hello} = world'

```

如果要转义双引号，可以使用反斜杠 `\`

```python python-shell
>>> f"{hello} = \"hello\""
'world = "hello"'
```

## 12. 居中字符串

![image.png](https://i.loli.net/2020/11/15/hCow9RlfMXsLpxK.png)

可以使用 `var:^N` 来使字符串居中，其中 `var` 是要显示的变量， `N` 是字符串长度。如果 `N` 小于 `len(var)` ，则 Python 会显示所有字符串。

```python python-shell

>>> hello = 'world'

>>> f"{hello:^11}"

'   world   '

>>> f"{hello:*^11}"

'***world***'

# 右侧添加了额外的填充字符

>>> f"{hello:*^10}"

'**world***'

# `N` 小于 len(hello)

>>> f"{hello:^2}"

'world'

```

## 13. 添加千分位分割符

f-string 还允许我们自定义数字。一种常见的操作是在每个千分位之间添加下划线

```python python-shell
>>> big_num = 1234567890

>>> f"{bing_num:_}"
'1_234_567_890'
```

事实上，可以使用任意的符号来做分割符。下面是使用 `,` 来做千位分割符的示例：

```python python-shell

>>> big_num = 1234567890

>>> f"{big_num:, }"

'1, 234, 567, 890'

```

也可以使用逗号分割浮点数，并一同设置显示精度

```python python-shell
>>> num = 2343552.6516251625

>>> f"{num:,.3f}"
'2,343,552.652'
```

也可以和 `replace` 结合使用，用空格做千分位分隔符

``` python
>>> big_num = 1234567890

>>> f"{big_num:,}".replace(',', ' ')
'1 234 567 890'
```

## 14. 使用科学技术法（指针计数法）格式化数字

使用 `e` 或 `E` 选项可以以科学技术法格式化数字。

``` python
>>> num = 2343552.6516251625

>>> f"{num:e}"
'2.343553e+06'

>>> f"{num:E}"
'2.343553E+06'

>>> f"{num:.2e}"
'2.34e+06'

>>> f"{num:.4E}"
'2.3436E+06'

```

## 15. 在 F-String 中使用 `if-else` 表达式

f-string 还可以计算更复杂的表达式，例如内联 `if/else` ：

``` python
>>> a = 'this is a'

>>> b = 'this is b'

>>> f"{a if 10 > 5 else b}"
'this is a'

>>> f"{a if 10 < 5 else b}"
'this is b'
```

## 16. 在 F-String 中使用字典

你可以在 f-string 中使用字典，唯一的要求是使用与包围表达式的引号不同的表达式。

```python python-shell

>>> color = {'R': 123, 'G': 145, 'B': 255}

>>> f"{color['R']}"

'123'

>>> f'{color["G"]}'

'145'

>>> f"RGB = ({color['R']}, {color['G']}, {color['B']})"

'RGB = (123, 145, 255)'

```

## 17. 连接 F-String 字符串

串联 f-string 字符串 就像链接常规字符串一样，可以隐式地连接，或者通过 `+` 运算符和 `str.join` 来显示地执行此操作。

```python python-shell
# 隐式字符串连接
>>> f"{123}" " = " f"{100}" " + " f"{20}" " + " f"{3}"
'123 = 100 + 20 + 3'

# 使用 `+` 运算符显示连接
>>> f"{12}" + " != " + f"{13}"
'12 != 13'

# 使用 `str.join` 连接
>>> " ".join((f"{13}", f"{45}"))
'13 45'

>>> "#".join((f"{13}", f"{45}"))
'13#45'
```

## 18. 格式化显示 `datetime` 对象

f-string 还支持格式化 datetime 对象。这个过程和 `str.format` 格式的日期非常相似。有关受支持格式的更多信息，可以查看[这个表](https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes)

![image.png](https://i.loli.net/2020/11/15/z5xGnARBDjOYiPL.png)

```python python-shell

>>> import datetime

>>> now = datetime.datetime.now()

>>> ten_days_ago = now - datetime.timedelta(days=10)

>>> f"{ten_days_ago:%Y-%m-%d %H:%M:%S}"

'2020-11-05 18:34:34'

>>> f'{now:%Y-%m-%d %H:%M:%S}'

'2020-11-15 18:34:34'

```

## 19. 修复 F-String 的无效语法错误

如果使用不正确，f-string 会抛出 `SyntaxError`，最常见的原因是在双引号 f-string 中使用双引号

```python python-shell
>>> color = {"R": 123, "G": 145, "B": 255}

>>> f"{color["R"]}"
  File "<ipython-input-43-1a7f5d512400>", line 1
    f"{color["R"]}"
    ^
SyntaxError: f-string: unmatched '['

>>> f'{color['R']}'
  File "<ipython-input-44-3499a4e3120c>", line 1
    f'{color['R']}'
    ^
SyntaxError: f-string: unmatched '['
```

另一个常见情况是在低版本中使用 f-string。f-string 是在 Python 3.6 版本中引入的，如果在低于此版本中使用，则解释器将抛出 `SyntaxError: invalid syntax.` 异常

```python python-shell

>>> f"this is an old version"

  File "<stdin>", line 1

    f"this is an old version"
                            ^

SyntaxError: invalid syntax

```

如果看到 `invalid syntax` ，先确保仔细检查正在运行的 Python 版本。

## 20. 使用 F-String 给数字补零

可以使用 `{expr:0len}` 格式在数字前面补0,其中 `len` 是返回字符串的总长度。
<!-- 表达式中可以包括一个符号选项。
在默认情况下，`+` 表示符号应用于正数和负数，`-`仅用于负数。有关更多信息，可以查阅[字符串格式规范](https://docs.python.org/3/library/string.html#format-specification-mini-language) -->

```python python-shell
>>> num = 42

>>> f"{num:05}"
'00042'

>>> f'{num:+010}'
'+000000042'

>>> f'{num:-010}'
'0000000042'

>>> f"{num:010}"
'0000000042'

>>> num = -42

>>> f'{num:+010}'
'-000000042'

>>> f'{num:010}'
'-000000042'

>>> f'{num:-010}'
'-000000042'
```

## 21. 在 F-String 中显示换行

可以将换行符 `\n` 与 f-string 一起使用以显示多行字符串。

```python python-shell

>>> multi_line = (f'R: {color["R"]}\nG: {color["G"]}\nB: {color["B"

    ...: ]}\n')

>>> multi_line

'R: 123\nG: 145\nB: 255\n'

>>> print(multi_line)

R: 123
G: 145
B: 255

```

或者，也可以使用三引号来表示多行字符串。f-string 不仅支持换行符 `\n` ， 还可以添加 `tab`

```python python-shell
>>> other = f"""R: {color["R"]}
    ...: G: {color["G"]}
    ...: B: {color["B"]}
    ...: """

>>> print(other)
R: 123
G: 145
B: 255
```

使用 `TAB` 的示例：

```python python-shell

>>> other = f'''

    ...: this is an example
    ...:
    ...: of color {color["R"]}
    ...:
    ...: '''

>>> other

'\nthis is an example\n\n\tof color 123\n    \n'

>>> print(other)

this is an example

    of color 123

>>>

```
