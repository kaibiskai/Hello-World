//
//  UIButton+Extension.h
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, UIButtonImageType) {
    UIButtonImageLeft,//default is left
    UIButtonImageRight,
    UIButtonImageNormal = UIButtonImageLeft
};
@interface UIButton (Extension)
// title or image should have one at least
+ (nullable instancetype)buttonWithTitle:(nullable NSString*)title imageNamed:(nullable NSString*)ImageName target:(nullable id)target action:(nullable SEL)action;
//this method maybe change bounds to fit image and title if smaller ;if called , must afert set frame ;default size is 17
-(void)setFontSize:(CGFloat)size;
//default is left ,neednot set left ,shoule be called after fontSize
-(void)setType:(UIButtonImageType)type;
@end
