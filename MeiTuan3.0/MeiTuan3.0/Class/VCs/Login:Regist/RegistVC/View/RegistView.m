//
//  RegistView.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RegistView.h"
@interface RegistView ()
@property (nonatomic,assign) NSInteger index;
@end
@implementation RegistView
- (instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kNavHeight, kScreenWidth, kCellHeight);
        self.backgroundColor = kWhiteColor;
        self.index = index;
        [self createViews];
    }
    return self;
}
-(void)createViews {
    NSArray *arr = @[@"1.输入手机号",@"2.输入验证码",@"3.输入密码"];
    for (int i =0; i<arr.count; i++) {
        [self topViewWithFrame:CGRectMake(self.width/arr.count*i, 0, self.width/arr.count, kCellHeight) text:arr[i] textColor:(i==self.index)?kDefaulsColor:kBlackColor];
    }
}
- (void)topViewWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"credit_cell_rightArrow"]];
    imageView.width = imageView.image.size.width;
    imageView.height = imageView.image.size.height;
    imageView.y = (view.height-imageView.height)/2;
    imageView.x = view.width-imageView.width;
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.y, view.width-imageView.width, imageView.height)];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [self addSubview:view];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
