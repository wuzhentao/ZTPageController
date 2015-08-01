//
//  view.h
//  draw
//
//  Created by 武镇涛 on 15/7/26.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloodView : UIView

@property (nonatomic,weak)UIColor  *color;

@property (nonatomic,assign)BOOL isStroke;

@property (nonatomic,assign)BOOL isLine;

@property (nonatomic,assign)CGColorRef FillColor;
@end
