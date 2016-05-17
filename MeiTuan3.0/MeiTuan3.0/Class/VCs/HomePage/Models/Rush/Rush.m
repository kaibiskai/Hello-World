//
//  Rush.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Rush.h"

@implementation Rush
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.act = [ActivityArea actWithDic:dic[@"activityArea"]];
        self.topics = @[].mutableCopy;
        for (NSDictionary *top in dic[@"topicArea"]) {
            TopicArea *topic = [TopicArea topicWithDic:top];
            [self.topics addObject:topic];
        }
    }
    return self;
}
+ (instancetype)rushWithDic:(NSDictionary*)dic {
    return [[self alloc]initWithDic:dic];
}
+ (instancetype)lastRush{
    Rush *rush = [[Rush alloc]init];
    rush.act = [ActivityArea lastAct];
    rush.topics = [NSMutableArray arrayWithArray:[TopicArea allLastTopicArea]];
    return rush;
}
- (void)cacheRush {
    [self.act cacheActivityArea];
    [TopicArea cacheTopicAreaWithTopicAreas:self.topics];
}
+ (void)rushRequestWithCompletion:(void(^)(Rush *rush))completion {
    [HttpManager httpGet:MT_HOME_RushUrl parameters:nil progress:nil completion:^(NSError * _Nonnull error, NSDictionary * _Nonnull dic) {
        Rush *rush;
        if (dic) {
        rush = [Rush rushWithDic:dic[@"data"][0][@"resource"]];
            [rush cacheRush];
        }
        if (completion) {
            completion(rush);
        }
    }];
}
@end
@interface  ActivityArea()<NSCoding>
@end
@implementation ActivityArea
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.activityImgUrl = [NSString editUrl:dic[@"activityImgUrl"]];
        self.mdcLogoUrl = dic[@"deals"][@"mdcLogoUrl"];
        self.cateDesc = dic[@"deals"][@"cateDesc"];
        self.price = [dic[@"deals"][@"price"] integerValue];
        self.campaignPrice = [dic[@"deals"][@"campaignprice"] integerValue];
        self.timeTravel = [dic[@"end"] integerValue]-[dic[@"start"] integerValue];
    }
    return self;
}
+ (instancetype)actWithDic:(NSDictionary*)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.activityImgUrl = [coder decodeObjectForKey:@"imgUrl"];
        self.mdcLogoUrl = [coder decodeObjectForKey:@"logo"];
        self.cateDesc = [coder decodeObjectForKey:@"desc"];
        self.price = [coder decodeIntegerForKey:@"price"];
        self.campaignPrice = [coder decodeIntegerForKey:@"cam"];
        self.timeTravel = [coder decodeIntegerForKey:@"time"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.activityImgUrl forKey:@"imgUrl"];
    [coder encodeObject:self.mdcLogoUrl forKey:@"logo"];
    [coder encodeObject:self.cateDesc forKey:@"desc"];
    [coder encodeInteger:self.price forKey:@"price"];
    [coder encodeInteger:self.campaignPrice forKey:@"cam"];
    [coder encodeInteger:self.timeTravel forKey:@"time"];
}
+ (instancetype)lastAct {
    return (ActivityArea*)[JsonManager plistWithContentsOfFileName:@"Activity"];
}
- (void)cacheActivityArea {
    [JsonManager plist:self writeToFileName:@"Activity"];
}
@end
@interface TopicArea ()<NSCoding>

@end
@implementation TopicArea
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
+ (instancetype)topicWithDic:(NSDictionary*)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.deputyTitle = [coder decodeObjectForKey:@"title"];
        self.mainTitleImg = [coder decodeObjectForKey:@"main"];
        self.entranceImgUrl = [coder decodeObjectForKey:@"imgUrl"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.deputyTitle forKey:@"title"];
    [coder encodeObject:self.mainTitleImg forKey:@"main"];
    [coder encodeObject:self.entranceImgUrl forKey:@"imgUrl"];
    
}
+ (NSArray*)allLastTopicArea {
   return (NSArray*)[JsonManager plistWithContentsOfFileName:@"TopicArea"];
    
}
+ (void)cacheTopicAreaWithTopicAreas:(NSArray<TopicArea*>*)areas {
    [JsonManager plist:areas writeToFileName:@"TopicArea"];
}
@end