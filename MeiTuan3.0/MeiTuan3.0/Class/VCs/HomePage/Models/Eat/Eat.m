//
//  Eat.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Eat.h"

@implementation Eat
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.imageurl = [NSString editUrl:self.imageurl];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (instancetype)eatWithDic:(NSDictionary*)dic {
    return  [[self alloc]initWithDic:dic];
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.imageurl = [set stringForColumn:@"imageurl"];
        self.maintitle = [set stringForColumn:@"maintitle"];
        self.deputytitle = [set stringForColumn:@"deputytitle"];
        self.position = [set intForColumn:@"position"];
    }
    return self;
}
+ (NSArray*)lastEatPlays {
   NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:nil setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        Eat *eat = [[self alloc]initWithFMSet:set];
        [dataArr addObject:eat];
    }];
    return arr;
}
+ (void)eatRequestWithCompletion:(void(^)(NSArray<Eat *>*eat))completion {
    [HttpManager httpGet:MT_HOME_EatUrl parameters:nil progress:nil completion:^( NSError * _Nonnull error, NSDictionary * _Nonnull dic) {
        NSMutableArray *eats = [NSMutableArray array];
        if (dic) {
            [DataTool dataToolCreateTableForModel:self withAttributes: @{@"imageurl":@"text",@"maintitle":@"text",@"deputytitle":@"text",@"position":@"integer"}];
            [DataTool dataToolDeleteDataFromTable:self withCondition:nil];
            NSArray *arr = dic[@"data"];
            for (NSDictionary *dic in arr) {
                Eat *eat = [Eat eatWithDic:dic];
                [eats addObject:eat];
                [DataTool dataToolInsertTable:self withAttributes:@{@"imageurl":eat.imageurl,@"maintitle":eat.maintitle,@"deputytitle":eat.deputytitle,@"position":[NSNumber numberWithInteger:eat.position]}];
            }
        }
        if (completion) {
            completion(eats);
        }
    }];
}
@end
