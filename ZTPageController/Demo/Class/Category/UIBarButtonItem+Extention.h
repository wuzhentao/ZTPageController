//
//  UIBarButtonItem+Extention.h
//  01-UI架构
//
//  Created by 武镇涛 on 15/5/25.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)

+ (UIBarButtonItem *)itemWithtTarget:(id)target anction:(SEL)action image:(NSString *)image highlightimage:(NSString*)highlightimage;
@end
