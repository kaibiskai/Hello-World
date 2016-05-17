//
//  OtherTool.h
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, UIAlertButtonType) {
    UIAlertButtonTypeSure,//default
    UIAlertButtonTypeSureAndCancel,
};
@class User,UIViewController;
@interface OtherTool : NSObject
+ (void)otherToolpresentLoginVCFromCurrentVC:(UIViewController *)VC;
+ (void)otherToolFromVC:(UIViewController*)VC presentAlertWithMessage:(NSString*)message completion:(void(^)(BOOL cancel))completion alertType:(UIAlertButtonType)type;
@end
