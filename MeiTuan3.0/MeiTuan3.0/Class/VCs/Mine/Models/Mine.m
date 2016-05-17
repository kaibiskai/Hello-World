//
//  Mine.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Mine.h"

@implementation Mine
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (NSArray*)allData {
    NSArray *arr = [JsonManager normalPlistWithContentsOfFileName:@"mine"];
    NSMutableArray *data = [NSMutableArray array];
    for (int i =0; i<arr.count; i++) {
        NSArray *subArr = arr[i];
        NSMutableArray *subData = [NSMutableArray array];
        for (NSDictionary *dic in subArr) {
            Mine *mine = [[Mine alloc]initWithDic:dic];
            [subData addObject:mine];
        }
        [data addObject:subData];
    }
    return data;
}
@end
