//
//  UIBarButtonItem+Extention.m
//  01-UI架构
//
//  Created by 武镇涛 on 15/5/25.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extention)

//底部工具的封装
+ (UIBarButtonItem *)itemWithtTarget:(id)target anction:(SEL)action image:(NSString *)image highlightimage:(NSString*)highlightimage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightimage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
