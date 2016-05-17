//
//  RushView.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RushView.h"
#import "Rush.h"
#import "UIImageView+WebCache.h"
#import "CountDownView.h"
#define kHeight 160.f*kScalHeight
@interface RushView ()

@end
@implementation RushView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, kScreenWidth, kHeight);
    }
    return self;
}
- (void)setRush:(Rush *)rush {
    //清空所有子控件
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i =  0; i<rush.topics.count; i++) {
       UIView*view = [self subViewWithTopic:rush.topics[i] frame:CGRectMake(kScreenWidth/2, self.height/2*i, kScreenWidth/2, self.height/2) tag:i];
        view.backgroundColor = kWhiteColor;
        view.layer.borderWidth = 1;
        view.layer.borderColor = kRGBColor(235, 235, 242, 1).CGColor;
        [self addSubview:view];
    }
    UIView *view = [self rushViewWithAct:rush.act];
    view.layer.borderWidth = 1;
    view.backgroundColor = kWhiteColor;
    view.layer.borderColor = kRGBColor(235, 235, 242, 1).CGColor;
    [self addSubview:view];
}
- (UIView*)rushViewWithAct:(ActivityArea*)act {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    [button addTarget:self action:@selector(actButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UIImageView *titleImg = [[UIImageView alloc]init];
    titleImg.center = CGPointMake(view.center.x, kCut);
    titleImg.bounds = CGRectMake(0, 0, view.width/2+2*kCut, 3*kCut);
    [titleImg sd_setImageWithURL:[NSURL URLWithString:act.activityImgUrl]];
    [view addSubview:titleImg];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2*kCut, titleImg.y+titleImg.height+kCut, 0, kCut)];
    label.text = @"距离结束还有";
    label.width = [label.text widthWithFontSize:12];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    CountDownView *countView = [[CountDownView alloc]initWithFrame:CGRectMake(label.x+label.width, titleImg.y+titleImg.height+kCut/2, 0, 2*kCut)];
    countView.timeTravel = act.timeTravel;
    [view addSubview:countView];
    UIImageView *menu = [[UIImageView alloc]init];
    menu.center = CGPointMake(view.center.x, countView.height+countView.y+kCut/2+(titleImg.width-kCut*2)/3);
    menu.layer.borderWidth = 1;
    menu.bounds = CGRectMake(0, 0, titleImg.width-kCut*2, 2*(titleImg.width-kCut*2)/3);
    [menu sd_setImageWithURL:[NSURL URLWithString:act.mdcLogoUrl]];
    [view addSubview:menu];
    UILabel *title = [[UILabel alloc]init];
    title.center = CGPointMake(view.center.x, menu.y+menu.height+kCut);
    title.font = [UIFont systemFontOfSize:12];
    title.text = act.cateDesc;
    title.textAlignment = NSTextAlignmentCenter;
    title.bounds = CGRectMake(0, 0, view.width, kCut);
    [view addSubview:title];
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(titleImg.x, title.y+title.height+kCut/2, view.width/4, kCut)];
    price.text = [NSString stringWithFormat:@"￥%ld",act.price];
    price.textColor = kDefaulsColor;
    price.font = [UIFont systemFontOfSize:12];
    price.width = [price.text widthWithFontSize:15];
    [view addSubview:price];
    UILabel *cut = [[UILabel alloc]initWithFrame:CGRectMake(price.x+price.width+kCut, price.y, 0, kCut)];
    cut.textColor = [UIColor orangeColor];
    cut.text = [NSString stringWithFormat:@"再减%ld",act.price-act.campaignPrice];
    cut.font = [UIFont systemFontOfSize:12];
    cut.width = [cut.text widthWithFontSize:15];
    [view addSubview:cut];
    return view;
}
- (UIView*)subViewWithTopic:(TopicArea*)topic frame:(CGRect)frame tag:(NSInteger)tag{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.frame = view.bounds;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    UIImageView *titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(kCut, kCut, view.width/2-2*kCut, 2.5*kCut)];
    [titleImg sd_setImageWithURL:[NSURL URLWithString:topic.mainTitleImg]];
    [view addSubview:titleImg];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(view.width/2, kCut, view.width/2-kCut, view.height-2*kCut)];
    [image sd_setImageWithURL:[NSURL URLWithString:topic.entranceImgUrl]];
    [view addSubview:image];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(titleImg.x,1.5*kCut+titleImg.height, 0, kCut)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = topic.deputyTitle;
    label.width = [label.text widthWithFontSize:15];
    [view addSubview:label];
    return view;
}
- (void)buttonClick:(UIButton*)sender {
    
}
- (void)actButtonClick: (UIButton*)sender {
    
}
@end