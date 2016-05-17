//
//  HomeItem.m
//  BeautifulGroup
//
//  Created by student on 16/4/22.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HomeItem.h"

@implementation HomeItem
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.imageUrl = [NSString editUrl:self.imageUrl];
        self.subTag = dic[@"campaign"][@"tag"];
        if (self.subTag==nil) {
            self.subTag = @"";
        }
    }
    return self;
}
+(instancetype)itemWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.subTitle = [set stringForColumn:@"subTitle"];
        self.imageUrl = [set stringForColumn:@"imgUrl"];
        self.title = [set stringForColumn:@"title"];
        self.mainMessage = [set stringForColumn:@"mainMsg"];
        self.mainMessage2 = [set stringForColumn:@"mainMsg2"];
        self.subMessage = [set stringForColumn:@"subMsg"];
        self.topRightInfo = [set stringForColumn:@"top"];
        self.bottomRightInfo = [set stringForColumn:@"bottom"];
        self.subTag =[set stringForColumn:@"subTag"];
    }
    return self;
}
+ (NSArray*)lastModels {
    NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:nil setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        HomeItem *model = [[self alloc]initWithFMSet:set];
        [dataArr addObject:model];
    }];
    return arr;
}
+ (void)itemRequestWithCompletion:(void(^)(NSArray<HomeItem *>*models))completion {
    [HttpManager httpGet:MT_HOME_ShopsUrl parameters:nil progress:nil completion:^( NSError * _Nonnull error, NSDictionary * _Nonnull dic) {
        NSMutableArray *models = [NSMutableArray array];
        if (dic) {
            [DataTool dataToolCreateTableForModel:self withAttributes: @{@"subTitle":@"text",@"imgUrl":@"text",@"title":@"text",@"mainMsg":@"text",@"mainMsg2":@"text",@"subMsg":@"text",@"top":@"text",@"bottom":@"text",@"subTag":@"text"}];
            [DataTool dataToolDeleteDataFromTable:self withCondition:nil];
            NSArray *arr = dic[@"data"];
            for (NSDictionary *dic in arr) {
                HomeItem *model = [self itemWithDic:dic];
                [models addObject:model];
                [DataTool dataToolInsertTable:self withAttributes:@{@"subTitle":model.subTitle,@"imgUrl":model.imageUrl,@"title":model.title,@"mainMsg":model.mainMessage,@"mainMsg2":model.mainMessage2,@"subMsg":model.subMessage,@"top":model.topRightInfo,@"bottom":model.bottomRightInfo,@"subTag":model.subTag}];
            }
        }
        if (completion) {
            completion(models);
        }
    }];
}
@end
