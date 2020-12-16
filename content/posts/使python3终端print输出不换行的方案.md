---
title: "使python3终端print输出不换行的方案"
date: 2017-02-12T03:40:26+08:00
draft: false
slug: solution-to-make-python3-terminal-print-output-without-line-break
---

用python3做进度条的时候，需要输出两个print，一个显示开始，一个显示结果，这就需要两个print的输出在同一行上

# 通过io库实现

这是来自[贴吧大神](http://tieba.baidu.com/p/1333075731)的解决方案，另辟奚径，挺有意思的。

```python
    import io

    output = io.StringIO()
    output.write('First line.')
    print('Second line.', file=output)

    contents = output.getvalue()+'\r'

    output.close()
    print(contents)
```

# 通过设置print第二个参数

根据 [官方手册](https://docs.python.org/3.1/tutorial/inputoutput.html)的说法，python3 中 `print` 默认在输出后面加上当前平台的换行符，我们只要禁用这个功能，就可以实现两个 `print` 输出在同一行了：

```python
    print("First line.", end='')
    # 要在输出的最后加上\r，否则会有特殊字符出现，原因不明
    print("Second line.\r", end='')
```