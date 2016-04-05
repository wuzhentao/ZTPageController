//
//  ViewController.m
//  02-练习
//
//  Created by 武镇涛 on 15/7/15.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "ZTViewController.h"
#import "UIView+Extension.h"
#import "ZTPage.h"


@interface ZTViewController ()<UIScrollViewDelegate,MenuViewDelegate,NSCacheDelegate>

@property (nonatomic,strong)MenuView *MenuView;
@property (nonatomic,strong)UIScrollView *detailScrollView;
@property (nonatomic,strong)NSArray *subviewControllers;
@property (nonatomic,strong)NSMutableArray *controllerFrames;
@property (nonatomic,strong)UIViewController *selectedViewConTroller;
@property (nonatomic,strong)NSArray *titles;
//正在出现的控制器
@property (nonatomic,strong)NSMutableDictionary *displayVC;
@property (nonatomic,assign)int  selectedIndex;
//内存管理机制，设置countlimit可以使内存机制中存储控制器的最大数量
@property (nonatomic,strong)NSCache *controllerCache;
@end

@implementation ZTViewController
#pragma mark Lazy load
- (NSArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableDictionary *)displayVC {
    if (!_displayVC) {
        _displayVC = [NSMutableDictionary dictionary];
    }
    return _displayVC;
}

- (NSArray *)subviewControllers {
    if (!_subviewControllers) {
        _subviewControllers = [NSMutableArray array];
    }
    return _subviewControllers;
}

- (UIScrollView *)detailScrollView {
    if (!_detailScrollView) {
        self.detailScrollView = [[UIScrollView alloc]init];
        self.detailScrollView.backgroundColor = [UIColor whiteColor];
        self.detailScrollView.pagingEnabled = YES;
        self.detailScrollView.delegate = self;
        [self.view addSubview:self.detailScrollView];
    }
    return _detailScrollView;
}

- (NSMutableArray *)controllerFrames {
    if (!_controllerFrames) {
        _controllerFrames = [NSMutableArray array];
    }
    return _controllerFrames;
}

- (NSCache *)controllerCache {
    if (!_controllerCache) {
        _controllerCache = [[NSCache alloc] init];
        // 设置数量限制
        if(self.countLimit) {
            _controllerCache.countLimit = self.countLimit;
        }else{
            _controllerCache.countLimit = 4;
        }
    }
    return _controllerCache;
}
#pragma mark 加载
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"新闻";
}

- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style {
    
    if (self = [super init]) {
        switch (style) {
            case MenuViewStyleLine:
                self.style = MenuViewStyleLine;
                break;
            case MenuViewStyleFoold:
                self.style = MenuViewStyleFoold;
                break;
            case MenuViewStyleFooldHollow:
                self.style = MenuViewStyleFooldHollow;
                break;
            default:
                self.style = MenuViewStyleDefault;
                break;
        }
    }
    return self;
}

- (void)loadVC:(NSArray *)viewcontrollerClass AndTitle:(NSArray *)titles {
    self.subviewControllers = viewcontrollerClass;
    self.titles  = titles;
    [self loadMenuViewWithTitles:self.titles];
}

- (void)loadMenuViewWithTitles:(NSArray *)titles {
    MenuView *Menview = [[MenuView alloc]initWithMneuViewStyle:self.style AndTitles:titles];
    [self.view addSubview:Menview];
    Menview.delegate = self;
    self.MenuView = Menview;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    for (int j = 0; j < self.subviewControllers.count; j++) {
        CGFloat X = j * ScreenWidth;
        CGFloat Y = 0;
        CGFloat height = self.view.height;
        CGRect frame = CGRectMake(X, Y, ScreenWidth, height);
        [self.controllerFrames addObject:[NSValue valueWithCGRect:frame]];
    }
    
    //如果不是在tabbar中需要将MenuView的y值设置为Y+20（导航控制器高度+状态栏高度）
//    GFloat y =  NavigationBarHeight
    self.MenuView.frame = CGRectMake(0, 0, ScreenWidth, MenuHeight);
    self.detailScrollView.frame = CGRectMake(0, self.MenuView.y+self.MenuView.height, ScreenWidth,ScreenHeight - self.detailScrollView.y);
    self.detailScrollView.contentSize = CGSizeMake(self.subviewControllers.count * self.detailScrollView.width, 0);
    
    [self addViewControllerViewAtIndex:0];
}


- (void)addViewControllerViewAtIndex:(int)index {
    
    Class vclass = self.subviewControllers[index];
    UIViewController *vc = [[vclass alloc]init];
    vc.view.frame = [self.controllerFrames[index] CGRectValue];
    [self.displayVC setObject:vc forKey:@(index)];
    [self addChildViewController:vc];
    [self.detailScrollView addSubview:vc.view];
    self.selectedViewConTroller = vc;
}

- (void)removeViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
    [self.displayVC removeObjectForKey:@(index)];
    
    if ([self.controllerCache objectForKey:@(index)]) return;
    [self.controllerCache setObject:viewController forKey:@(index)];
  
}

- (BOOL)isInScreen:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat ScreenWith = self.detailScrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.detailScrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) >contentOffsetX && x - contentOffsetX < ScreenWith ){
        return YES;
    }else{
        return NO;
    }
    
}

- (void)addCachedViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    
    [self addChildViewController:viewController];
    [self.detailScrollView addSubview:viewController.view];
    [self.displayVC setObject:viewController forKey:@(index)];
    
    self.selectedViewConTroller = viewController;
}

#pragma mark delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int Page = (int)(scrollView.contentOffset.x/self.view.width + 0.5);
    int index = (int)(scrollView.contentOffset.x/self.view.width);
    CGFloat rate = scrollView.contentOffset.x/self.view.width;
    for (int i = 0; i <self.subviewControllers.count; i++) {
        //取出frame
        
        CGRect frame = [self.controllerFrames[i] CGRectValue];
        //首先从显示中的控制器中取；
        UIViewController *vc = [self.displayVC objectForKey:@(i)];
        
        if ([self isInScreen:frame]) {
            if (vc == nil) {//从内存中取
                vc = [self.controllerCache objectForKey:@(i)];
                if (vc) {//把内存中的取出来创建，保证此控制器是之前消除的控制器
                    [self addCachedViewController:vc atIndex:i];
                }else{//再创建
                 [self addViewControllerViewAtIndex:i];
                }
            }
        }else{
            if (vc) {//如果不在屏幕中显示，将其移除
                [self removeViewController:vc atIndex:i];
            }
        }
    }
    self.selectedViewConTroller = [self.displayVC objectForKey:@(Page)];
    //滚动使MenuView中的item移动
    [self.MenuView SelectedBtnMoveToCenterWithIndex:index WithRate:rate];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width )return;
    int Page = (int)(scrollView.contentOffset.x/self.view.width);
   
   //因为我用的UItabbar做的展示，所以切换tabar的时候，会出现控制器不清除的结果，使得通知中心紊乱，其他控制器也可以接收当前控制器发送的通知，所以，我把通知名称设置为唯一的；
    NSString *name  = [NSString stringWithFormat:@"scrollViewDidFinished%zd",self.MenuView.style];
    NSDictionary *info = @{
                           @"index":@(Page)};
    [[NSNotificationCenter defaultCenter]postNotificationName:name  object:nil userInfo:info];
          
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width )return;
   
    if(!decelerate){
    int Page = (int)(scrollView.contentOffset.x/ScreenWidth);
    
    if (Page == 0) {
        [self.MenuView selectWithIndex:Page AndOtherIndex:Page + 1 ];
    }else if (Page == self.subviewControllers.count - 1){
        [self.MenuView selectWithIndex:Page AndOtherIndex:Page - 1];
    }else{
        [self.MenuView selectWithIndex:Page AndOtherIndex:Page + 1 ];
        [self.MenuView selectWithIndex:Page AndOtherIndex:Page - 1];
    }
    }
}

- (void)MenuViewDelegate:(MenuView *)menuciew WithIndex:(int)index {
    
    [self removeViewController:self.selectedViewConTroller atIndex:_selectedIndex];
    
    self.detailScrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
    self.selectedIndex = index;
    
    UIViewController *vc = [self.displayVC objectForKey:@(index)];
    if (vc == nil) {
        vc = [self.controllerCache objectForKey:@(index)];
        if (vc) {
            [self addCachedViewController:vc atIndex:index];
        }else{
            [self addViewControllerViewAtIndex:index];
        }
    }
}
/**
 *  NSCache的代理方法，打印当前清除对象 */
//- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
//    //[NSThread sleepForTimeInterval:0.5];
// 
//    NSLog(@"清除了-------> %@", obj);
//}
@end
