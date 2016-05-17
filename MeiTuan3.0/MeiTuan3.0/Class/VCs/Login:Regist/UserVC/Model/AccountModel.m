//
//  AccountModel.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "AccountModel.h"
#import "User.h"
@implementation AccountModel
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (NSMutableArray*)modelReadPlist:(NSString*)plist {
    NSString *path = [NSString pathForResource:plist];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *dataArr = @[].mutableCopy;
    for (int i =0; i<arr.count; i++) {
        NSArray *subArr = arr[i];
        NSMutableArray *cates = @[].mutableCopy;
        for (NSDictionary *dic in subArr) {
            AccountModel *model = [[AccountModel alloc]initWithDic:dic];
            if ([model.title isEqualToString:@"用户"]) {
                model.title = [User currentUser].account;
            }
            [cates addObject:model];
        }
        [dataArr addObject:cates];
    }
    return dataArr;
}
@end
