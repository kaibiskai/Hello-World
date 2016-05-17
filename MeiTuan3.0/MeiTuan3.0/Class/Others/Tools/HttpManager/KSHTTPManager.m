//
//  KSHTTPManager.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "KSHTTPManager.h"
static NSString *const baseStr = @"http://www.baidu.com";
@implementation KSHTTPManager
+ (instancetype)sharedManager {
    static KSHTTPManager *__shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareManager = [[KSHTTPManager alloc]initWithBaseURL:[NSURL URLWithString:baseStr]];
    });
    return __shareManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
