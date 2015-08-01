//
//  TabBarViewController.m
//  01 - 网易
//
//  Created by 武镇涛 on 15/7/9.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "ZTViewController.h"
#import "ZTTableViewController.h"
#import "ZTPage.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    
    Class vc1 = [ZTTableViewController class];
    NSArray *vcclass = @[vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1,vc1];
    NSArray *titles = @[@"太原理工大学",@"热点",@"视频",@"体育",@"事实",@"NBA",@"美女",@"美女",@"体育",@"体育",@"优衣库",@"沈阳地铁"];


    ZTViewController *vca = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleDefault];
    [vca loadVC:vcclass AndTitle:titles];
    [self controller:vca title:@"网易style" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];

   
    ZTViewController *vcb = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleLine];
    [vcb loadVC:vcclass AndTitle:titles];
    [self controller:vcb title:@"搜狐style" image:@"tabbar_icon_reader_normal" selectedImage:@"tabbar_icon_reader_highlight"];
    
    
    ZTViewController *vcc = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleFoold];
    [vcc loadVC:vcclass AndTitle:titles];
    [self controller:vcc title:@"腾讯style1" image:@"tabbar_icon_media_normal"selectedImage:@"tabbar_icon_media_highlight"];
    
    
    ZTViewController *vcd = [[ZTViewController alloc]initWithMneuViewStyle:MenuViewStyleFooldHollow];
    [vcd loadVC:vcclass AndTitle:titles];
    [self controller:vcd title:@"腾讯style2" image:@"tabbar_icon_found_normal" selectedImage:@"tabbar_icon_found_highlight"];
}

- (void)controller:(UIViewController*)controller title:(NSString *)title
             image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.title = title;
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = rgb(128, 128, 128);
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSForegroundColorAttributeName] = [UIColor redColor];
    [controller.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:dict1 forState:UIControlStateSelected];
    
   NavigationViewController *nav = [[NavigationViewController alloc]initWithRootViewController:controller];   
    [self addChildViewController:nav];
    
}
@end
