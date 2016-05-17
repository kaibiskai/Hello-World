//
//  SortView.m
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "SortView.h"
#import "Cate.h"
@interface SortView ()
@property (retain,nonatomic) UIScrollView *rightScroll,*leftScroll;
@property (retain,nonatomic) NSArray *dataArr;
@property (assign,nonatomic) NSInteger leftTag,rightTag;
@property (retain,nonatomic) NSMutableArray *leftButtons,*rightButtons;
@property (retain,nonatomic) Cate *selectedCate;
@property (copy,nonatomic) void(^block)(NSString*name);
@property (copy,nonatomic) void(^disBlock)(void);
@end
@implementation SortView
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
    [self createLeftButtons];
}
- (void)createLeftButtons {
    self.dataArr = [Cate allCates];
    self.leftScroll.contentSize = CGSizeMake(0, self.dataArr.count*kCellHeight);
    for (int i =0; i<self.dataArr.count; i++) {
        Cate *cate = self.dataArr[i];
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
- (void)leftClick:(UIButton*)sender {
    if (!sender.selected) {
        sender.selected = YES;
        UIButton *button = self.leftButtons[self.leftTag];
        button.selected = NO;
        self.leftTag = sender.tag;
    }
    self.selectedCate = self.dataArr[sender.tag];
    for (UIButton *button in self.rightScroll.subviews) {
        [button removeFromSuperview];
    }
    [self.rightButtons removeAllObjects];
    if (self.selectedCate.subLists.count==0) {
        self.block(self.selectedCate.name);
        [self removeFromSuperview];
    }else {
        self.rightScroll.contentSize = CGSizeMake(0, kCellHeight*self.selectedCate.subLists.count);
        for (int i =0; i<self.selectedCate.subLists.count; i++) {
            SubCate *subCate = self.selectedCate.subLists[i];
            UIButton *button = [UIButton buttonWithTitle:subCate.name imageNamed:nil target:self action:@selector(rightClick:)];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            button.frame = CGRectMake(0, kCellHeight*i, self.rightScroll.width, kCellHeight);
            [button setTitleColor:kDefaulsColor forState:UIControlStateSelected];
            [button setTitleColor:kBlackColor forState:UIControlStateNormal];
            button.tag = i;
            if (i==0) {
                button.selected = YES;
            }
            [self.rightScroll addSubview:button];
            [self.rightButtons addObject:button];
        }
    }
}
- (void)rightClick:(UIButton*)sender {
    if (!sender.selected) {
        sender.selected = YES;
        UIButton *button = self.rightButtons[self.rightTag];
        button.selected = NO;
        self.rightTag = sender.tag;
    }
    SubCate *subCate = self.selectedCate.subLists[sender.tag];
    self.block(subCate.name);
    [self removeFromSuperview];
}
- (void)SortViewDidSelectItemCompletion:(void(^)(NSString*name))completion dismiss:(void(^)(void))dismiss {
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
@end
