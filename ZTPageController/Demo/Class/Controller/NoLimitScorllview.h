//
//  NoLimitScorllview.h
//  ZTTableViewController
//
//  Created by 武镇涛 on 15/7/28.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoLimitScorllview;

@protocol NoLimitScorllviewDelegate <NSObject>

@optional
- (void)NoLimitScorllview:(NoLimitScorllview *)scorllview ImageDidSelectedWithIndex:(int)index;

@end

@interface NoLimitScorllview : UIView

@property (nonatomic,weak)id<NoLimitScorllviewDelegate> delegate;
- (instancetype)initWithShowImages:(NSArray *)images AndTitals:(NSArray *)titals;

@end
