//
//  UIBarButtonItem+Extension.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#define kHeight 30.f
#define kWidth 35.f*kScalWidth
@implementation UIBarButtonItem (Extension)
+(nullable instancetype)itemAddTarget:(nullable id)target action:(nullable SEL)action withTitle:(nullable NSString*)title imageNamed:(nullable NSString*)name type:(UIButtonImageType)type {
    UIButton *button = [UIButton buttonWithTitle:title imageNamed:name target:target action:action];
    button.fontSize = 15;
    if (button.width<kWidth) {
        button.width = kWidth;
    }
    if (button.height<kHeight) {
        button.height = kHeight;
    }
    button.type = type;
    return  [[self alloc]initWithCustomView:button];
}

-(void)setTag:(NSInteger)tag {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        button.tag = tag;
    }
}
+ ( NSArray*)itemsAddTarget:( id)target action:( SEL)action withTitles:( NSArray*)titles imageNamed:( NSArray*)names {
    NSMutableArray *arr = @[].mutableCopy;
    NSInteger count = 0;
    if (titles) {
        count = titles.count;
    }else count = names.count;
    for (int i = 0; i<count; i++) {
     UIBarButtonItem *item =  [self itemAddTarget:target action:action withTitle:titles[i] imageNamed:names[i] type:UIButtonImageLeft];
        item.tag = i;
        [arr addObject:item];
    }
    return arr;
}
- (void)setTitleColor:(UIColor*)color forState:(UIControlState)state {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        [button setTitleColor:color forState:state];
    }
}
- (void)setTitle:(NSString*)title forState:(UIControlState)state {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        [button setTitle:title forState:state];
    }
}
+ (UIButton*)currentButtonWithTag:(NSInteger)tag fromItems:(NSArray*)items{
    UIBarButtonItem *item = items[tag];
    UIButton *button = item.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        return button;
    }
    return nil;
}
@end
