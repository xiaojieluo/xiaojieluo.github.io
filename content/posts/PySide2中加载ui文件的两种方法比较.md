---
title: "PySide2中加载ui文件的两种方法比较"
date: 2019-09-12T13:10:35+08:00
draft: false
slug: comparison-of-two-methods-of-loading-ui-files-in-pyside2
tags:

    - Python
    - PySide2
    - Qt5

---

先将 QtDesigner 生成的.ui 文件转换成 python 类，再在项目中导入这个类。

可以使用 `` pyside2-uic `` 这个工具来实现 ui 文件转 python 类的操作，执行以下命令即可：

``` shell
    pyside2-uic mainwindow.ui -o ui_mainwindow.py
```

<!--more-->

注意： [PySide2](https://doc.qt.io/qtforpython/tutorials/basictutorial/uifiles.html) 官网中的例子是使用管道将 pyside2-uic 的输出结果直接写入文件中，实测在 windows 下会有 bug, 会输出不可见字符，导致程序无法运行，所以还是建议使用 pyside2-uic 的 -o 参数，输出到文件中
之后可以在项目中直接导入生成的 python 类。

``` python
    from ui_mainwindow import Ui_MainWindow
```

现在开始使用它，我们要先创建一个自定义的类，并在类中使用生成的 ui 类
为了更好的理解，看下面的代码

``` python
    import sys
    from PySide2.QtWidgets import QApplication, QMainWindow
    from PySide2.QtCore import QFile
    from ui_mainwindow import Ui_MainWindow

    class MainWindow(QMainWindow):
        def __init__(self):
            super(MainWindow, self).__init__()
            self.ui = Ui_MainWindow()
            self.ui.setupUi(self)

    if __name__ == "__main__":
        app = QApplication(sys.argv)

        window = MainWindow()
        window.show()

        sys.exit(app.exec_())
```

下面两行负责从UI 文件加载生成的 Python 类

``` python
    self.ui = Ui_MainWindow()
    self.ui.setupUi(self)
```

> Note: 每次更改UI文件时，都必须再次运行 ` ` pyside2-uic ` `

## 使用 `` QUiLoader `` 直接加载 .ui 文件

直接加载 ui 文件，我们需要使用 `` QtUiTool `` 模块

``` python
    from PySide2.QtUiTool import QUiLoader
```

`` QUiLoader `` 使我们可以动态加载 ui 文件并立即使用它。

``` python
    ui_file = QFile("mainwindow.ui")
    ui_file.open(QFile.ReadOnly)

    loader = QUiLoader()
    window = loader.load(ui_file)
    window.show()
```

一个完整的示例是像这样的：

``` python
    # main.py
    import sys
    from PySide2.QtUiTools import QUiLoader
    from PySide2.QtWidgets import QApplication
    from PySide2.QtCore import QFile, QIODevice

    if __name__ == "__main__":
        app = QApplication(sys.argv)

        ui_file_name = "mainwindow.ui"
        ui_file = QFile(ui_file_name)
        if not ui_file.open(QIODevice.ReadOnly):
            print("Cannot open {}: {}".format(ui_file_name, ui_file.errorString()))
            sys.exit(-1)
        loader = QUiLoader()
        window = loader.load(ui_file)
        ui_file.close()
        if not window:
            print(loader.errorString())
            sys.exit(-1)
        window.show()

        sys.exit(app.exec_())
```

我们只需要运行下列命令来执行它：

``` shell
    python main.py
```

<!-- []:
.. 区别：
.. 1. 直接用 QUiLoader 加载 .ui文件
..     #### 优点
..     - 使用 QtDesigner 编辑 ui之后， 可以直接看到效果，省略了编译成 python 类的操作，方便开发
..     #### 缺点
..     - 会导致在用pyinstaller 打包成 exe 运行时找不到.ui文件，从而无法启动程序 -->
