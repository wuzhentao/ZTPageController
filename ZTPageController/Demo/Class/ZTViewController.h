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
/**
 *  缓存中可以存储最大控制器的量（经测试，NSCache初步是FIFO的，它的最大数量最大就是这个属性，超过会释放当前最先进入的
 */
@property (nonatomic,assign)NSInteger countLimit;
//加载控制器的类
- (void)loadVC:(NSArray *)viewcontrollerClass AndTitle:(NSArray*)titles;

- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style;
@end

