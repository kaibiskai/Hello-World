//
//  MineFooter.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MineFooter.h"
@interface MineFooter ()
@property (assign,nonatomic) CGFloat height;
@property (copy,nonatomic) Block block;
@end
@implementation MineFooter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
        self.bounds = CGRectMake(0, 0, kScreenWidth, self.height);
        self.backgroundColor = kWhiteColor;
    }
    return self;
}
- (void)createView {
    NSArray *titles = @[@"待付款",@"待使用",@"待评价",@"退款/售后"];
    NSArray *images = @[@"icon_ordercenter_payment",@"icon_ordercenter_consumption",@"icon_ordercenter_review",@"icon_ordercenter_refund"];
    for (int i =0 ; i<titles.count; i++) {
        UIView *view = [self createViewWithImageNamed:images[i] title:titles[i]tag:i];
        view.center = CGPointMake(kScreenWidth/8+kScreenWidth/4*i, self.height/2);
        [self addSubview:view];
    }
}
- (UIView *)createViewWithImageNamed:(NSString*)imageName title:(NSString*)title tag:(NSInteger)tag {
    UIView *view = [[UIView alloc]init];
    UIImage *image = [UIImage imageNamed:imageName];
    view.bounds = CGRectMake(0, 0, kScreenWidth/4, 2*(image.size.height+kCut));
    UIButton *button = [UIButton buttonWithTitle:nil imageNamed:nil target:self action:@selector(buttonClick:)];
    button.frame = view.bounds;
    button.tag = tag;
    [view addSubview:button];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.center = CGPointMake(button.center.x,image.size.height);
    imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.height*2, view.width, kCut)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    self.height = view.height;
    return view;
}
- (void)buttonClick:(UIButton*)sender {
    self.block(sender.tag);
}
- (void)foorerButtonDidClickWithCompletion:(Block)completion {
    if (completion) {
        self.block = completion;
    }
}
@end
