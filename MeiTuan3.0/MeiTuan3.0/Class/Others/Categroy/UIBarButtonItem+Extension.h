//
//  UIBarButtonItem+Extension.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIBarButtonItem (Extension)
//custom barButtonItem , title or imageName should have one at least ;item size is {35,30} at least
+(nullable instancetype)itemAddTarget:(nullable id)target action:(nullable SEL)action withTitle:(nullable NSString*)title imageNamed:(nullable NSString*)name type:(UIButtonImageType)type;
// custon barButtonItems, default button tag  start from 0 ,if need not,do not change
+ (nonnull NSArray*)itemsAddTarget:(nonnull id)target action:(nonnull SEL)action withTitles:(nullable NSArray*)titles imageNamed:(nullable NSArray*)names;
//
- (void)setTitleColor:(nullable UIColor*)color forState:(UIControlState)state;
//change custom barTitle for buttonState
- (void)setTitle:(nullable NSString*)title forState:(UIControlState)state;
//get customView:button
+ (nullable UIButton*)currentButtonWithTag:(NSInteger)tag fromItems:(nullable NSArray*)items;
@end
