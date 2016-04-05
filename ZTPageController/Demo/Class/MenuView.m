//
//  MenuView.m
//  02-练习
//
//  Created by 武镇涛 on 15/7/19.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "MenuView.h"
#import "MenuViewBtn.h"
#import "FloodView.h"
#import "ZTPage.h"
@interface MenuView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *MenuScrollView;
@property (nonatomic,strong)MenuViewBtn *selectedBtn;
@property (nonatomic,strong)FloodView  *line;
@property (nonatomic,assign)CGFloat sumWidth;

@end

@implementation MenuView

- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style AndTitles:(NSArray *)titles {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        switch (style) {
            case MenuViewStyleLine:
                _style = MenuViewStyleLine;
                break;
            case MenuViewStyleFoold:
                _style = MenuViewStyleFoold;
                break;
            case MenuViewStyleFooldHollow:
                _style = MenuViewStyleFooldHollow;
                break;
            default:
                _style = MenuViewStyleDefault;
                break;
        }
    [self loadWithScollviewAndBtnWithTitles:titles];
        //接收通知
    NSString *name = [NSString stringWithFormat:@"scrollViewDidFinished%zd",style];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(move:) name:name object:nil];

    }
    return self;
}

- (void)loadWithScollviewAndBtnWithTitles:(NSArray *)titles {
    
    UIScrollView *MenuScrollView = [[UIScrollView alloc]init];
    MenuScrollView.showsVerticalScrollIndicator = NO;
    MenuScrollView.showsHorizontalScrollIndicator = NO;
    MenuScrollView.backgroundColor = [UIColor whiteColor];
    MenuScrollView.delegate = self;
    self.MenuScrollView= MenuScrollView;
    [self addSubview:self.MenuScrollView];
//btn创建
    
    for (int i = 0; i < titles.count; i++) {
        MenuViewBtn *btn = [[MenuViewBtn alloc ]initWithTitles:titles AndIndex:i];
        btn.tag = i;
        if (self.style == MenuViewStyleFoold || self.style == MenuViewStyleFooldHollow) {
            btn.fontName = @"BodoniSvtyTwoOSITCTT-Bold";
            btn.fontSize = 16;
            btn.normalColor = kNomalColor;
            btn.selectedColor = kSelectedColorFontFlood;
            if (self.style == MenuViewStyleFooldHollow) {
                btn.selectedColor = kSelectedColorFloodH;
            }
        }else{
            //这里为引入第三方定义字体，只需导入你想要的otf/ttf的字体源文件，修改一下plist中的font设置，再将字体家族和字体名称打印出来。具体详细过程请问谷歌。
            btn.fontName = @"经典细圆简";
        }
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textColor = kNomalColor;
        [self.MenuScrollView addSubview:btn];
        }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    MenuViewBtn *btn = nil;
    MenuViewBtn *btn1 = nil;
    self.sumWidth = 0;
    
    for (int i = 0; i < self.MenuScrollView.subviews.count; i++){
        btn= self.MenuScrollView.subviews[i];
        if (i>=1) {
            btn1 = self.MenuScrollView.subviews[i-1];
        }
        UIFont *titleFont = btn.titleLabel.font;
        CGSize titleS = [btn.titleLabel.text sizeWithfont:titleFont];
        btn.width = titleS.width + 2 *BtnGap;
        btn.x = btn1.x + btn1.width + BtnGap;
        btn.y = 0;
        btn.height = self.height - 2;
        self.sumWidth += btn.width;
        if (btn == [self.MenuScrollView.subviews lastObject]) {
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            self.MenuScrollView.size = CGSizeMake(width, height);
            
            self.MenuScrollView.contentSize = CGSizeMake(btn.x + btn.width+ BtnGap, 0);
            self.MenuScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        btn = nil;
        btn1 = nil;
    }
    if (self.MenuScrollView.contentSize.width < self.width) {
        CGFloat margin = (ScreenWidth - self.sumWidth)/(self.MenuScrollView.subviews.count + 1);
        for (int i = 0; i < self.MenuScrollView.subviews.count; i++){
            btn= self.MenuScrollView.subviews[i];
            if (i>=1) {
                btn1 = self.MenuScrollView.subviews[i-1];
            }
            btn.x = btn1.x + btn1.width + margin;
            
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.style == MenuViewStyleDefault) {
        MenuViewBtn *btn = [self.MenuScrollView.subviews firstObject];
        [btn ChangSelectedColorAndScalWithRate:0.1];
    }else{
        [self addProgressView];
    }
}

- (void)addProgressView {
    if (self.style == MenuViewStyleFooldHollow || self.style == MenuViewStyleFoold){
        self.line.FillColor = kNormalColorFlood.CGColor;
        self.line.height = self.height/2 + 2;
        self.line.y = (self.height - self.line.height)/2;
        
        if (self.style == MenuViewStyleFooldHollow) {
            self.line.isStroke = YES;
            self.line.color = [UIColor redColor];
        }
    }else{
        self.line.isLine = YES;
        self.line.height = 2;
        self.line.y = self.height - self.line.height;
        self.line.FillColor = [UIColor redColor].CGColor;
    }
}

- (void)click:(MenuViewBtn *)btn {
    
    if (self.selectedBtn == btn) return;
    if ([self.delegate respondsToSelector:@selector(MenuViewDelegate:WithIndex:)]) {
        [self.delegate MenuViewDelegate:self WithIndex:(int)btn.tag];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    [self MoveCodeWithIndex:(int)btn.tag];
    
    if (self.style == MenuViewStyleDefault) {

        [btn selectedItemWithoutAnimation];
        [self.selectedBtn deselectedItemWithoutAnimation];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.line.x = btn.x;
            self.line.width = btn.width;
        }];
    }
    self.selectedBtn = btn;
}

- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)Pagerate {
    
    int page  = (int)(Pagerate +0.5);
    CGFloat rate = Pagerate - index;
    int count = (int)self.MenuScrollView.subviews.count;
    
    if (Pagerate < 0) return;
    if (index == count-1 || index >= count -1) return;
    if ( rate == 0)    return;
   
    self.selectedBtn.selected = NO;
    MenuViewBtn *currentbtn = self.MenuScrollView.subviews[index];
    MenuViewBtn *nextBtn = self.MenuScrollView.subviews[index + 1];

    if (self.style == MenuViewStyleDefault) {
        
        [currentbtn ChangSelectedColorAndScalWithRate:rate];
        [nextBtn ChangSelectedColorAndScalWithRate:1-rate];
    }else {
        CGFloat margin;
        if (Pagerate < count-2){
            if (self.MenuScrollView.contentSize.width < self.width){
                margin = (ScreenWidth - self.sumWidth)/(self.MenuScrollView.subviews.count + 1);
                self.line.x =  currentbtn.x + (currentbtn.width + margin + BtnGap)* rate;
            }else{
                margin = BtnGap;
                self.line.x =  currentbtn.x + (currentbtn.width + margin)* rate;
            }
            
            self.line.width =  currentbtn.width + (nextBtn.width - currentbtn.width)*rate;
            [currentbtn ChangSelectedColorWithRate:rate];
            [nextBtn ChangSelectedColorWithRate:1-rate];
        }
    }
   self.selectedBtn = self.MenuScrollView.subviews[page];
   self.selectedBtn.selected = YES;

}

- (void)move:(NSNotification *)info {
    
    NSNumber *index =  info.userInfo[@"index"];
    int tag = [index intValue];
    [self MoveCodeWithIndex:tag];
}
/**
 *  使选中的按钮位移到scollview的中间
 */
- (void)MoveCodeWithIndex:(int )index {
    MenuViewBtn *btn = self.MenuScrollView.subviews[index];
    CGRect newframe = [btn convertRect:self.bounds toView:nil];
    CGFloat distance = newframe.origin.x  - self.centerX;
    CGFloat contenoffsetX = self.MenuScrollView.contentOffset.x;
    int count = (int)self.MenuScrollView.subviews.count;
    if (index > count-1) return;

    if ( self.MenuScrollView.contentOffset.x + btn.x   > self.centerX ) {
        
        [self.MenuScrollView setContentOffset:CGPointMake(contenoffsetX + distance + btn.width, 0) animated:YES];
    }else{
        
        [self.MenuScrollView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {

        [scrollView setContentOffset:CGPointMake(0 , 0)];
    }else if(scrollView.contentOffset.x + self.width >= scrollView.contentSize.width){
        
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - self.width, 0)];
    }
}

- (void)selectWithIndex:(int)index AndOtherIndex:(int)tag {
    self.selectedBtn = self.MenuScrollView.subviews[index];
    MenuViewBtn *otherbtn = self.MenuScrollView.subviews[tag];

    self.selectedBtn.selected = YES;
    otherbtn.selected = NO;
    
    self.line.x = self.selectedBtn.x;
    self.line.width = self.selectedBtn.width;

    [self MoveCodeWithIndex:(int)self.selectedBtn.tag];
}

- (FloodView *)line {
    if (!_line) {
        _line = [[FloodView alloc]init];
        MenuViewBtn *btn = [self.MenuScrollView.subviews firstObject];
        _line.x = btn.x ;
        _line.width = btn.width;
        _line.backgroundColor = [UIColor clearColor];
        _line.color = kSelectedColor;
         [self.MenuScrollView addSubview:_line];
    }
    return _line;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
