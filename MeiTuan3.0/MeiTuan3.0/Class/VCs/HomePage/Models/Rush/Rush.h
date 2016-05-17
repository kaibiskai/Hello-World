//
//  Rush.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityArea;
@interface Rush : NSObject
@property (retain,nonatomic) ActivityArea *act;
@property (retain,nonatomic) NSMutableArray *topics;
+ (instancetype)rushWithDic:(NSDictionary*)dic;
//not net ,called to read old data
+ (instancetype)lastRush;
//request rush
+ (void)rushRequestWithCompletion:(void(^)(Rush *rush))completion;
@end
@interface  ActivityArea: NSObject
@property (copy,nonatomic) NSString *activityImgUrl;
@property (copy,nonatomic) NSString *mdcLogoUrl;
@property (copy,nonatomic) NSString *cateDesc;
@property (assign,nonatomic) NSInteger price;
@property (assign,nonatomic) NSInteger campaignPrice;
@property (assign,nonatomic) NSInteger timeTravel;

+ (instancetype)actWithDic:(NSDictionary*)dic;
//read and write plist
- (void)cacheActivityArea;
+ (instancetype)lastAct;
@end
@interface TopicArea : NSObject
@property (copy,nonatomic) NSString *deputyTitle;
@property (copy,nonatomic) NSString *mainTitleImg;
@property (copy,nonatomic) NSString *entranceImgUrl;
+ (instancetype)topicWithDic:(NSDictionary*)dic;
//read and write plist
+ (NSArray*)allLastTopicArea;
+ (void)cacheTopicAreaWithTopicAreas:(NSArray<TopicArea*>*)areas;
@end