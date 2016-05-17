//
//  OtherTool.m
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "OtherTool.h"
#import "LoginViewController.h"
#import "User.h"
@implementation OtherTool
+ (void)otherToolpresentLoginVCFromCurrentVC:(UIViewController *)VC {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        KSNavController *nav = [[KSNavController alloc]initWithRootViewController:loginVC];
        [VC presentViewController:nav animated:YES completion:nil];
}
+ (void)otherToolFromVC:(UIViewController*)VC presentAlertWithMessage:(NSString*)message completion:(void(^)(BOOL cancel))completion alertType:(UIAlertButtonType)type{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion(NO);
        }
    }]];
    if (type == UIAlertButtonTypeSureAndCancel) {
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(YES);
            }
        }]];
    }
    [VC presentViewController:alert animated:YES completion:nil];
}
@end
