//
//  MenuViewBtn.h
//  02-练习
//
//  Created by 武镇涛 on 15/7/20.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewBtn : UIButton

@property (nonatomic,copy   ) NSString *fontName;
@property (nonatomic,assign ) CGFloat  fontSize;
@property (nonatomic,assign ) CGFloat  NomrmalSize;
@property (nonatomic,assign ) CGFloat  rate;
// normal状态的字体颜色
@property (nonatomic, strong) UIColor  *normalColor;
//selected状态的字体颜色
@property (nonatomic, strong) UIColor  *selectedColor;
@property (nonatomic,strong ) UIColor  *titlecolor;

- (instancetype)initWithTitles:(NSArray *)titles AndIndex:(int)index;

- (void)selectedItemWithoutAnimation;
- (void)deselectedItemWithoutAnimation;
- (void)ChangSelectedColorWithRate:(CGFloat)rate;
- (void)ChangSelectedColorAndScalWithRate:(CGFloat)rate;
@end
