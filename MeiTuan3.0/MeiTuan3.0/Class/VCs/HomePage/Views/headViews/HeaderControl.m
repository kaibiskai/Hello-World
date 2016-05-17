//
//  HeaderControl.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HeaderControl.h"
#import "RecommendView.h"
#import "RushView.h"
#import "EatView.h"
#import "HotChannelView.h"
@implementation HeaderControl
- (instancetype)initWithRecomBlock:(void(^)(Recom*recom))recomBlock requestBlock:(void(^)(NSMutableArray*))requestBlock
{
    self = [super init];
    if (self) {
        self.headers = @[].mutableCopy;
        RecommendView *reView = [RecommendView recommendWithClickBlock:recomBlock];
        [self.headers addObject:reView];
        RushView *rushView = [[RushView alloc]init];
        [self.headers addObject:rushView];
        EatView *eatView = [[EatView alloc]init];
        [self.headers addObject:eatView];
        HotChannelView *hotView = [[HotChannelView alloc]init];
        [self.headers addObject:hotView];
        [self createNormalHead];
        [self createLastHead];
        if (requestBlock) {
            requestBlock(self.headers);
        }
    }
    return self;
}
- (void)createNormalHead {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kCellHeight)];
    label.text = @"❤️猜你喜欢";
    [self.headers addObject:label];
}
- (void)createLastHead {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8*kCut+kCellHeight)];
    NSArray *arr = @[@"愿意让我们更了解你吗",@"让美团的推荐更符合你的胃口"];
    for (int i =0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2*(kCut+kCut*i), kScreenWidth, 2*kCut)];
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我的美团DNA" forState:UIControlStateNormal];
    button.backgroundColor = kDefaulsColor;
    button.frame = CGRectMake(2, 6*kCut, kScreenWidth-4, kCellHeight);
    [button addTarget:self action:@selector(myGroup) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.headers addObject:view];
}
- (void)myGroup {
    
}
@end
