# ZTPageController
模仿网易新闻和其他新闻样式做的一个菜单栏，栏中有各自的控制器。
##Demo展示
其中有4中展示样式’网易style' ’搜狐style' ’腾讯style1' ’网易style2'
**Demo** <br>
<img height="350" src="https://github.com/IOStao/ZTPageController/blob/master/ZTPageController/Demo/Demo3.gif" />
<br>
<br>
如果使用这个框架，你只需要这两个方法即可：
（其中vcclass是控制器的类，Title是控制器的标题，以数组的形式展示）
```objective-c
ZTViewController *vca =[[ZTViewControllealloc]initWithMneuViewStyle:MenuViewStyleDefault];
[vca loadVC:vcclass AndTitle:titles];

```
<br>