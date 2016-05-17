//
//  GuideView.m
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "GuideView.h"
@interface GuideView ()<UIScrollViewDelegate>
@property (retain,nonatomic)UIScrollView *scrollView;
@property (retain,nonatomic)UIPageControl *pageControl;
@property (retain,nonatomic)NSArray *images;
@property (copy,nonatomic) void(^block)(void);
@end
@implementation GuideView
- (instancetype)initWithImages:(NSArray<NSString*>*)images
{
    self = [super init];
    if (self) {
        self.frame = kScreenBounds;
        self.images = images;
        [self createViews];
        [self setUpViews];
    }
    return self;
}
-(void)createViews {
    self.scrollView =[[UIScrollView alloc]initWithFrame:kScreenBounds];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*self.images.count, 0);
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-kCellHeight, kScreenWidth, kCut)];
    self.pageControl.currentPageIndicatorTintColor = kDefaulsColor;
    self.pageControl.numberOfPages = self.images.count;
    [self addSubview:self.pageControl];
}
-(void)setUpViews {
    KSLog(@"%f",self.scrollView.contentSize.width);
    for (int i =0; i<self.images.count; i++) {
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:self.images[i]];
        [self.scrollView addSubview:imageView];
        if (i==self.images.count-1) {
            UIButton *button = [UIButton buttonWithTitle:@"立即体验" imageNamed:nil target:self action:@selector(guideButtonClick)];
            button.frame = CGRectMake(imageView.x+kCut, self.pageControl.y-kCellHeight-kCut, kScreenWidth-2*kCut, kCellHeight);
            button.backgroundColor = kDefaulsColor;
            [self.scrollView addSubview:button];
        }
    }
}
#pragma mark--scrollView.delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}
#pragma mark--guideButtonClick
- (void)guideButtonClick {
    [[NSUserDefaults standardUserDefaults]setObject:kVERSION forKey:@"GUIDEVERSION"];
    [self removeFromSuperview];
    self.block();
}
#pragma mark--show on window and click guideButton block
- (void)showSelfWithCompletion:(void(^)(void))completion {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    if (completion) {
        self.block = completion;
    }
}
@end
