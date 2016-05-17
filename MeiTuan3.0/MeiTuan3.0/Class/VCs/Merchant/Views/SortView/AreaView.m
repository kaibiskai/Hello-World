//
//  AreaView.m
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "AreaView.h"
#import "Area.h"
@interface AreaView ()
@property (retain,nonatomic) UIScrollView *rightScroll,*leftScroll;
@property (retain,nonatomic) NSArray *dataArr;
@property (assign,nonatomic) NSInteger leftTag,rightTag;
@property (retain,nonatomic) NSMutableArray *leftButtons,*rightButtons;
@property (retain,nonatomic) Area *area;
@property (copy,nonatomic) void(^block)(NSString*name);
@property (copy,nonatomic) void(^disBlock)(void);
@end
@implementation AreaView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kNavHeight+kCellHeight, kScreenWidth, kScreenHeight-kNavHeight-kCellHeight-kTabHeight);
        self.backgroundColor = kTranslucentColor;
        self.leftButtons = @[].mutableCopy;
        self.rightButtons = @[].mutableCopy;
        [self createScrollView];
    }
    return self;
}
- (void)createScrollView {
    self.rightScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, self.height-3*kNavHeight)];
    self.rightScroll.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.rightScroll];
    self.leftScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, self.height-3*kNavHeight)];
    self.leftScroll.backgroundColor = kWhiteColor;
    [self addSubview:self.leftScroll];
}
-(void)setCity:(City *)city {
    if (_city != city) {
        _city = city;
        self.dataArr = _city.areas;
        [self.leftButtons removeAllObjects];
        for (UIButton *button in self.leftScroll.subviews) {
            [button removeFromSuperview];
        }
        self.leftScroll.contentSize = CGSizeMake(0, self.dataArr.count*kCellHeight);
        for (int i =0; i<self.dataArr.count; i++) {
            Area *cate = self.dataArr[i];
            UIButton *button = [UIButton buttonWithTitle:cate.name imageNamed:nil target:self action:@selector(leftClick:)];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.tag = i;
            button.frame = CGRectMake(0, kCellHeight*i, self.leftScroll.width, kCellHeight);
            [button setTitleColor:kDefaulsColor forState:UIControlStateSelected];
            [button setTitleColor:kBlackColor forState:UIControlStateNormal];
            if (i==0) {
                button.selected = YES;
            }
            [self.leftScroll addSubview:button];
            [self.leftButtons addObject:button];
        }
    }
}
- (void)leftClick:(UIButton*)sender {
    if (!sender.selected) {
        sender.selected = YES;
        UIButton *button = self.leftButtons[self.leftTag];
        button.selected = NO;
        self.leftTag = sender.tag;
    }
    self.area = self.dataArr[sender.tag];
    self.block(self.area.name);
    [self removeFromSuperview];
}
- (void)viewDidSelectItemCompletion:(void(^)(NSString*name))completion dismiss:(void(^)(void))dismiss {
    if (completion) {
        self.block = completion;
    }
    if (dismiss) {
        self.disBlock = dismiss;
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        self.disBlock();
        [self removeFromSuperview];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
