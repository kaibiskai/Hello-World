//
//  User.m
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)initWithAccount:(NSString*)account psw:(NSString*)psw
{
    self = [super init];
    if (self) {
        self.account = account;
        self.psw = psw;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.account = [coder decodeObjectForKey:@"title"];
        self.psw = [coder decodeObjectForKey:@"subTitle"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.account forKey:@"title"];
    [coder encodeObject:self.psw forKey:@"subTitle"];
}
+(instancetype)currentUser {
    NSData *data = [NSData dataWithContentsOfFile:[NSString pathForFileUnderDocuWith:@"currentUser.plist"]];
    if (data) {
        User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return user;
    }
    return nil;
}
- (void)becomeCurrentUser {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:[NSString pathForFileUnderDocuWith:@"currentUser.plist"] atomically:YES];
}
+ (void)closeCurrentUserWithCompletion:(void(^)(void))completion {
    NSFileManager *manage = [NSFileManager defaultManager];
    if ([manage fileExistsAtPath:[NSString pathForFileUnderDocuWith:@"currentUser.plist"]]) {
        [manage removeItemAtPath:[NSString pathForFileUnderDocuWith: @"currentUser.plist"] error:nil];
        if (completion) {
            completion();
        }
    }
}
+ (NSMutableArray*)allLoginUsers {
    NSData *data = [NSData dataWithContentsOfFile:[NSString pathForFileUnderDocuWith:@"loginUsers.plist"]];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (arr) {
        return arr;
    }
    return @[].mutableCopy;
}
+(NSMutableArray*)searchLoginUsersWithAccount:(NSString*)account {
    NSMutableArray *arr = [self allLoginUsers];
    NSMutableArray *dataArr = @[].mutableCopy;
    if (arr) {
        for (User *user in arr) {
            if ([user.account containsString:account]) {
                [dataArr addObject:user];
            }
        }
    }
    return dataArr;
}
+ (NSMutableArray*)allUsers {
    NSData *data = [NSData dataWithContentsOfFile:[NSString pathForFileUnderDocuWith:@"allUsers.plist"]];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (arr) {
        return arr;
    }
    return @[].mutableCopy;
}
- (void)insertAllUsers {
    NSMutableArray *arr = [User allUsers];
    [arr addObject:self];
    NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [newData writeToFile:[NSString pathForFileUnderDocuWith:@"allUsers.plist"] atomically:YES];
}
- (void)becomeLoginUser {
    [self becomeCurrentUser];
    NSMutableArray *arr = [User allLoginUsers];
    for (User *user in arr) {
        if ([user.account isEqualToString:self.account]) {
            return;
        }
    }
    [arr insertObject:self atIndex:0];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [data writeToFile:[NSString pathForFileUnderDocuWith:@"loginUsers.plist"] atomically:YES];
    
}
- (void)loseLoginUser {
    NSMutableArray *arr = [User allLoginUsers];
    for (User *user in arr) {
        if ([user.account isEqualToString:self.account]) {
            [arr removeObject:user];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [data writeToFile:[NSString pathForFileUnderDocuWith:@"loginUsers.plist"] atomically:YES];
        }
    }
}
+ (instancetype)matchUserWithAccount:(NSString*)account {
    NSMutableArray *arr = [self allUsers];
    for (User *user in arr) {
        if ([user.account isEqualToString:account]) {
            return user;
        }
    }
    return nil;
}
+ (instancetype)matchPswWithAccount:(NSString*)account psw:(NSString*)psw {
    User *user = [self matchUserWithAccount:account];
    if (user&&[user.psw isEqualToString:psw]) {
        return user;
    }
    return nil;
}
+ (void)registWithPsw:(NSString*)psw completion:(void(^)(void))completion{
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    User *newUser = [[self alloc]initWithAccount:account psw:psw];
    [newUser becomeCurrentUser];
    [newUser becomeLoginUser];
    [newUser insertAllUsers];
    if (completion) {
        completion();
    }
}
+ (void)registWithAccount:(NSString *)account completion:(void (^)(BOOL))completion {
    User *user = [self matchUserWithAccount:account];
    if (user) {
        if (completion) {
            completion(NO);
            return;
        }
    }
    completion(YES);
}
@end
