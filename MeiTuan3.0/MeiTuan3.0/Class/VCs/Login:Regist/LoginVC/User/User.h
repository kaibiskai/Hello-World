//
//  User.h
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *psw;
+(NSMutableArray*)searchLoginUsersWithAccount:(NSString*)account;
+(instancetype)currentUser;
+ (void)closeCurrentUserWithCompletion:(void(^)(void))completion;
+ (instancetype)matchPswWithAccount:(NSString*)account psw:(NSString*)psw;
+ (void)registWithAccount:(NSString *)account completion:(void (^)(BOOL succeed))completion;
+ (void)registWithPsw:(NSString*)psw completion:(void(^)(void))completion;
+ (NSMutableArray*)allLoginUsers;
- (void)loseLoginUser;
- (void)becomeLoginUser;
@end
