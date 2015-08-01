//
//  view.m
//  draw
//
//  Created by 武镇涛 on 15/7/26.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "FloodView.h"

@implementation FloodView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];

    CGFloat radius;
    if (self.isLine) {
        radius = 2;
    }else if(self.isStroke){
        radius = 13;
    }else{
        radius = 10;
    }
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.5);
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    
    if (self.isStroke) {
        CGContextClosePath(context);
        CGContextSetStrokeColorWithColor(context, self.color.CGColor);
        CGContextStrokePath(context);
    }
    //填充半透明灰色
    //CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, self.FillColor);
    CGContextDrawPath(context,kCGPathFill);
    UIGraphicsEndImageContext();
    
}

@end
