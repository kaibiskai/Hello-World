//
//  UIButton+Extension.m
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (instancetype)buttonWithTitle:(NSString*)title imageNamed:(NSString*)ImageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (ImageName) {
        [button setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    }else {
//        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaulsColor forState:UIControlStateSelected];
    }
    if (title) {
        [button setTitle:title forState: UIControlStateNormal];
    }
    if (target&&action) {
       [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
-(void)setFontSize:(CGFloat)size{
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    CGFloat width = [self.currentTitle widthWithFontSize:size]+self.currentImage.size.width;
    if (self.width<width) {
        self.width = width;
    }
    CGFloat strHeight = [self.currentTitle heightWithFontSize:size];
    CGFloat imageHeight = self.currentImage.size.height;
    CGFloat height = (strHeight>imageHeight)?strHeight:imageHeight;
    if (self.height<height) {
        self.height = height;
    }
}
-(void)setType:(UIButtonImageType)type {
    if (self.currentImage&&self.currentTitle) {
        switch (type) {
            case UIButtonImageLeft:
                break;
            case UIButtonImageRight:{
                [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.width, 0, 0)];
                [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -self.width)];
            }
                break;
            default:
                break;
        }
    }
}
@end
