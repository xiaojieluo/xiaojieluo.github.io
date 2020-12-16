---
title: "Tornado中finish之后调用write出现错误"
date: 2017-02-23T13:57:04+08:00
draft: false
slug: an-error-occurs-when-calling-write-after-finish-in-tornado
tags: ["Python", "Tornado"]
---

<!-- ![tornado error](./error.png) -->

参考了 [知乎上的答案](https://www.zhihu.com/question/19787492) , 但是没有实现我想要的效果，最终在翻 tornado.web 的源代码时，找到了一个解决办法

在需要结束的地方抛出个 `Finish()` 异常就可以了，暂时还不清楚  Tornado 是如何处理这个异常的，以后有时间再看下实现过程

## example:

```python
    from tornado.web import Finish
    ...
    ...

    class IndexHandler(RequestHandler):
        def get(self):
            self.write("Hello")
            raise Finish()
            self.write("World")
```