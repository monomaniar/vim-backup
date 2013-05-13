=======
vim-backup
==========

my vim scipts

mysaves fold save the ctag and vim-start scripts.

---
简介
---
整个配置是按照适合编辑python,c++,js设置的，proto,xml,json的高亮等也都配置好了。缩进都是下载的google的风 格文件。

默认的快捷键Leader是逗号","。

---
严重注意
---
有些插件用的比较新，所以存在bug,请 一定看一下这些bug和处理：

1.安装了Synstaic插件在文件每次保存的时候会调用gcc做语法检查，提前发现错误.
http://www.vim.org/scripts/script.php?script_id=2736
导致的bug是保存时候需要连续保存两次才正常，所以设定了快捷键",w"保存文件连续保存两次规避bug.

类似的python也有检查，但也有有需要连续编辑两次的bug，保存时候请使用",w"快捷键.

在语法检查弹出的框是默认是-Wall,觉得讨厌在vimrc内搜，对应的配置行应该有注释怎么开启和关闭

2.用Unite.vim插件做查询，比较强大的查找插件

http://www.github.com/Shougo/unite.vim,https://github.com/tsukkee/unite-tag,https://github.com/tacroe/unite-mark

有bug，如果目录内有循环的软链接查询会死机。所以如果有递归的目录结构，查询时不要使用"\*\*"符号做递归子目录查询！！！！


3.自动完成和snipet是基于EasyTag和neocomplete

只会补全最近打开过的文件里的tag，在根目录的.vim_tags,和.vim_filetypes内存着最近的tag，过大的时候会很慢，需要定期清除，所以在启动工程的脚本内清理了。
neocomplete貌似和cppcomplete插件有冲突，选择这个是因为个人觉得提示函数名会导致自己依赖提示，而起的名字变的不好，喜欢cppcomplete的需要关闭neocomplete插件。

---
常用快捷键和命令
---

,cc     注释一行

,空格c 反注释一行

F3     全局字符查找插件，正则查找需要第一个字符是‘/’

F5      搜索当前目录文件

,ff       (FindFile）从工程根目录查找文件

,fb    （FindeBuffer）查找Buffer用来快速打开最近的文件

,ft    （FindTag）全局查找tag

:A    头文件和cpp文件切换

,fr    (FindRegister)查找剪贴板内容

,tl     (TagList)调出taglist

,tr     (TagList)调出taglist显示在右侧,默认是在左侧,所以当左右分屏时候为右侧的文件打开taglist使用

安装了自动文档Doxgen插件,命令是:Dox, :DoxLic,:DoxBlock

自动完成的快捷键换成了TAB，CTRL+P，CTRL+N，空格上屏。

snipet的快捷键是TAB和CTRL+K.

格式化XML文件已经有命令:PrettyXML

看文本文件时候，一行超过80个的红色高亮比较讨厌时候可以用快捷键",hon"去除(HighlightOverlengthNone)

自动语法检查时候屏幕下方的窗口有时候很碍眼，想关闭用快捷键",cll"(close location list )

自动语法检查时候导航错误位置的快捷键是''ln""lp"(location next)(location previous)


进入查文件时候屏幕上发的窗口，查找文件要输入名字得按'i',默认是只能用j,k来上下选择。回车是确认。

按i进入插入模式之后常用的是CTRL+W回删一级目录。

查找文件匹配路径时候用'/*/'匹配任意下一级目录。

查找文件时候屏幕上方的窗口用ESC关闭，因为有时候不小心按了TAB会进入对查到的文件的操作模式可以选择rename,split open等操作，但误操作会很烦人，同样也是ESC退出操作模式。

在",fb"(fine buffer)调出的查找文件窗口里根目录是系统目录，所以一般只i进去输文件名用来查找最近操作过的文件，但也是最常用的。


snipet的配置文件是在autoload/neosnippet下面。








剩下的命令和插件的配置可以看vimrc文件内的注释，每个插件都有下载地址和说明。

另外推荐个文章<高效编辑代码的七个习惯>

http://xbeta.info/7habits-edit.htm
