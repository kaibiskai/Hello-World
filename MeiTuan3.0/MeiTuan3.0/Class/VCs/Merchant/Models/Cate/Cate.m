//
//  Cate.m
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Cate.h"

@implementation Cate
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.subLists = @[].mutableCopy;
        NSArray *arr = dic[@"list"];
        for (int i =0;i<arr.count;i++) {
            NSDictionary *subDic = arr[i];
            SubCate *subCate = [[SubCate alloc]initWithDic:subDic];
            if (i==0) {
                subCate.selected = YES;
            }
            [self.subLists addObject:subCate];
        }
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSArray *)allCates {
    NSDictionary *dic = [JsonManager jsonWithContentsOfFileName:@"MerchantCategory"];
    NSArray *arr = dic[@"data"][@"morepage"];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        NSDictionary *subDic = arr[i];
        Cate *cate = [[Cate alloc]initWithDic:subDic];
        if (i==0) {
            cate.selected = YES;
        }
        [dataArr addObject:cate];
    }
    return dataArr;
}
@end
@implementation SubCate
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.count = [dic[@"count"] integerValue];
    }
    return self;
}
@end