//
//  Misc.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Misc.h"

@implementation Misc
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (NSArray*)allData {
    NSArray *arr = [JsonManager normalPlistWithContentsOfFileName:@"misc"];
    NSMutableArray *data = [NSMutableArray array];
    for (int i =0; i<arr.count; i++) {
        NSArray *subArr = arr[i];
        NSMutableArray *subData = [NSMutableArray array];
        for (NSDictionary *dic in subArr) {
            Misc *misc = [[Misc alloc]initWithDic:dic];
            [subData addObject:misc];
        }
        [data addObject:subData];
    }
    return data;
}
@end
