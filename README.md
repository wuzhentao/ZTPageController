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
<br>
##关于颜色和字体大小的设置
只需修改头文件中的宏，如下图：
<img height="350" src="https://github.com/IOStao/ZTPageController/blob/master/ZTPageController/Demo/Demo2.png" />

##还有一个内存管理的问题(这个属性是使当前缓存中储存最大子控制器的数量，这个是仿照网易实现的）
```objective-c
vca.countLimit = 5;
```
<br>
<br>
**结尾:**
* 如果发现bug和什么任何问题，请与我联系。
* 有好的意见或建议，可以联系我。
