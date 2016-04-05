//
//  NoLimitScorllview.m
//  ZTTableViewController
//
//  Created by 武镇涛 on 15/7/28.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "NoLimitScorllview.h"
#import "UIView+Extension.h"

@interface NoLimitScorllview ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel  *lable;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titals;
@property (nonatomic, assign) int  currentPage;
@property (nonatomic, assign) int  numberOfImages;
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, strong) NSMutableArray *currentView;
@end

@implementation NoLimitScorllview

- (NSArray *)images {
    if (!_images) {
        _images = [NSArray array];
    }
    return _images;
}

- (NSArray *)titals {
    if (!_titals) {
        _titals = [NSArray array];
    }
    return _titals;
}

- (NSMutableArray *)currentView {
    if (!_currentView) {
        _currentView = [NSMutableArray array];
    }
    return _currentView;
}

- (instancetype)initWithShowImages:(NSArray *)images AndTitals:(NSArray *)titals {
    
    if (self = [super init]) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
       
        self.width = width;
        self.height = 200;
        self.images = images;
        self.titals = titals;
        self.numberOfImages = (int)images.count;
         self.currentPage = 0;
       
        UIScrollView *main = [[UIScrollView alloc]init];
        main.frame = CGRectMake(0, 0, width, self.height - 20);
        main.showsVerticalScrollIndicator = NO;
        main.showsHorizontalScrollIndicator = NO;
        main.pagingEnabled = YES;
        main.delegate = self;
        main.contentSize = CGSizeMake(width * 3, 0);
        main.showsHorizontalScrollIndicator = NO;
        main.contentOffset = CGPointMake(width, 0);

        [self addSubview:main];
        self.scrollView = main;
        
                
        UILabel *lable = [[UILabel alloc]init];
        lable.frame = CGRectMake(30, self.height - 20, 300, 20);
        lable.text = titals[self.currentPage];
        [self addSubview:lable];
        self.lable = lable;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.frame = CGRectMake(300, self.height-20, width - 300, 20);
        pageControl.currentPageIndicatorTintColor = [UIColor redColor ];
        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        self.pageControl.numberOfPages = images.count;
        
        [self loadData];
        [self addtimer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addtimer) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removetimer) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)addtimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)loadData {
    self.pageControl.currentPage = self.currentPage;
    self.lable.text = self.titals[self.currentPage];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self getDisplayImagesWithCurpage:self.currentPage];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [self.currentView objectAtIndex:i];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        imageView.frame = CGRectMake(i * self.width, 0, self.width, self.height - 20);
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(int)page {
    int previous = [self cycleImageIndex:page -1];
    int next = [self cycleImageIndex:page +1];
    [self.currentView removeAllObjects];
  
    [self.currentView addObject:[self pageAtIndex:previous]];
    [self.currentView addObject:[self pageAtIndex:page]];
    [self.currentView addObject:[self pageAtIndex:next]];
}

- (int)cycleImageIndex:(int)index {
    if (index == -1) {
        return self.numberOfImages - 1;
    }else if (index == self.numberOfImages){
        return 0;
    }else{
        return index;
    }
}

- (void)next {
    CGFloat index =  self.scrollView.contentOffset.x + self.width;
    [self.scrollView setContentOffset:CGPointMake(index, 0) animated:YES];
}

- (void)removetimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (UIImageView *)pageAtIndex:(NSInteger)index {
    UIImageView *imageview = [[UIImageView alloc]init];
    NSString *name = [self.images objectAtIndex:index];
    imageview.image = [UIImage imageNamed:name];
    return imageview;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(NoLimitScorllview:ImageDidSelectedWithIndex:)]) {
        [self.delegate NoLimitScorllview:self ImageDidSelectedWithIndex:self.currentPage];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    //最后一张的后一张
    if(x >= (2*self.frame.size.width)) {
        self.currentPage = [self cycleImageIndex:self.currentPage + 1];
        [self loadData];
    }
    //第一张的前一张
    if(x <= 0) {
        self.currentPage = [self cycleImageIndex:self.currentPage - 1];
        [self loadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removetimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self addtimer];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
