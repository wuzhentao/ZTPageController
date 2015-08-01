//
//  ViewController.h
//  02-练习
//
//  Created by 武镇涛 on 15/7/15.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MenuView.h"
@interface ZTViewController : UIViewController

@property (nonatomic,assign)MenuViewStyle style;
//加载控制器的类
- (void)loadVC:(NSArray *)viewcontrollerClass AndTitle:(NSArray*)titles;

- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style;
@end

