//
//  MenuView.h
//  02-练习
//
//  Created by 武镇涛 on 15/7/19.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    MenuViewStyleDefault,     // 默认
    MenuViewStyleLine,        // 带下划线 (颜色会变化)
    MenuViewStyleFoold,       // 涌入效果 (填充)
    MenuViewStyleFooldHollow, // 涌入效果 (空心的)
    
} MenuViewStyle;


@class MenuView;

@protocol MenuViewDelegate <NSObject>

@optional

- (void)MenuViewDelegate:(MenuView*)menuciew WithIndex:(int)index;

@end

@interface MenuView : UIView

@property (nonatomic,weak)id<MenuViewDelegate> delegate;

@property (nonatomic,assign)MenuViewStyle style;


- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)rate;
- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style AndTitles:(NSArray *)titles;
- (void)selectWithIndex:(int)index AndOtherIndex:(int)tag;
@end
