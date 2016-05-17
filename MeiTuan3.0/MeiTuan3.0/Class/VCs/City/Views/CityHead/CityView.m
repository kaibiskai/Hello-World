//
//  CityView.m
//  MeiTuan3.0
//
//  Created by student on 16/5/13.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "CityView.h"
#define kButtonWidth (kScreenWidth-5*kCut)/3

@interface CityView ()
@property (copy,nonatomic)clickBlock block;
@property (retain,nonatomic) NSArray *arr;
@end
@implementation CityView
- (instancetype)initWithAreas:(NSArray*)areas
{
    self = [super init];
    if (self) {
        self.tag = kCityViewTag;
        self.arr = areas;
        [self createViews];
    }
    return self;
}
- (void)createViews{
    for (int i =0; i<self.arr.count; i++) {
    CityA *city = self.arr[i];
    UIButton *button = [self setButtonWithTitle:city.name frame:CGRectMake(kCut+(kButtonWidth+kCut)*(i%3),kCut/2+i/3*(kCellHeight+kCut), kButtonWidth, kCellHeight)];
        button.tag = i;
        [self addSubview:button];
    }
    self.frame = CGRectMake(0, 0, kScreenWidth, ((self.arr.count-1)/3+1)*(kCut+kCellHeight));
    
}
-(UIButton *)setButtonWithTitle:(NSString*)title frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithTitle:title imageNamed:nil target:self action:@selector(buttonClick:)];
    button.frame = frame;
    button.fontSize = 15;
    [button setBackgroundImage:[UIImage imageNamed:@"shopping_mall_btn_bg_press"] forState:UIControlStateNormal];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    return button;
}
- (void)buttonClick:(UIButton*)sender {
    CityA *city = self.arr[sender.tag];
    if ([city isKindOfClass:[CityA class]]) {
        city.lastest = YES;
    }
    self.block ();
}
- (void)cityButtonDidClickWithCompletion:(clickBlock)completion {
    if (completion) {
        self.block = completion;
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
