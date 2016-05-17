//
//  Recom.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Recom.h"

@implementation Recom
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+(instancetype)recomWithDic:(NSDictionary*)dic {
    return [[self alloc]initWithDic:dic];
}
+ (NSArray*)allRecoms {
    NSDictionary *dic = [JsonManager jsonWithContentsOfFileName:@"Home_Recommend"];
    NSArray *arr = dic[@"data"][@"homepage"];
    NSMutableArray *dataArr = @[].mutableCopy;
    for (NSDictionary *dataDic in arr) {
        Recom *recom =[[Recom alloc]initWithDic:dataDic];
        [dataArr addObject:recom];
    }
    return dataArr;
}
@end
