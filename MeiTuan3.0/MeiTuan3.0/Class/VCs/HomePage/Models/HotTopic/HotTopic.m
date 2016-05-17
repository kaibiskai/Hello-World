//
//  HotTopic.m
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HotTopic.h"

@implementation HotTopic
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+(instancetype)topicWithDic:(NSDictionary*)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.deputyTitle = [set stringForColumn:@"deputy"];
        self.entranceImgUrl = [set stringForColumn:@"imgUrl"];
        self.mainTitle = [set stringForColumn:@"main"];
    }
    return self;
}
+ (NSArray*)lastHotTopics {
    NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:nil setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        HotTopic *topic = [[self alloc]initWithFMSet:set];
        [dataArr addObject:topic];
    }];
    return arr;
}
+ (void)topicRequestWithCompletion:(void(^)(NSArray<HotTopic *>*topics))completion {
    [HttpManager httpGet:MT_HOME_HotTopicUrl parameters:nil progress:nil completion:^( NSError * _Nonnull error, NSDictionary * _Nonnull dic) {
        NSMutableArray *eats = [NSMutableArray array];
        if (dic) {
            [DataTool dataToolCreateTableForModel:self withAttributes: @{@"deputy":@"text",@"main":@"text",@"imgUrl":@"text"}];
            [DataTool dataToolDeleteDataFromTable:self withCondition:nil];
            NSArray *arr = dic[@"data"][0][@"resource"][@"cateArea"];
            for (NSDictionary *dic in arr) {
                HotTopic *topic = [self topicWithDic:dic];
                [eats addObject:topic];
                [DataTool dataToolInsertTable:self withAttributes:@{@"imgUrl":topic.entranceImgUrl,@"main":topic.mainTitle,@"deputy":topic.deputyTitle}];
            }
        }
        if (completion) {
            completion(eats);
        }
    }];
}
@end
