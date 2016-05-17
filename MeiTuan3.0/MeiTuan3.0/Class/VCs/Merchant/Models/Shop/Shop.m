//
//  Shop.m
//  MeiTuan
//
//  Created by student on 16/5/6.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Shop.h"

@implementation Shop
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.frontImg = [NSString editUrl:self.frontImg];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+(instancetype)shopWithDic:(NSDictionary*)dic {
    return  [[self alloc]initWithDic:dic];
}
+(void)shopRequestWithUrl:(NSString*)urlStr completion:(void(^)(NSArray<Shop *>*shops))completion {
    [HttpManager httpGet:urlStr parameters:nil progress:nil completion:^(NSError * _Nonnull error, NSDictionary * _Nonnull dic) {
        NSArray *arr = dic[@"data"];
        NSMutableArray *shops = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            Shop *shop = [Shop shopWithDic:dic];
            [shops addObject:shop];
        }
        if (completion) {
            completion(shops);
        }
    }];
}
@end
