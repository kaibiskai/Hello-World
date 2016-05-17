//
//  HotTopic.h
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTopic : NSObject
@property (copy,nonatomic) NSString *deputyTitle;
@property (copy,nonatomic) NSString *entranceImgUrl;
@property (copy,nonatomic) NSString *mainTitle;
+(instancetype)topicWithDic:(NSDictionary*)dic;
+ (NSArray*)lastHotTopics;
+ (void)topicRequestWithCompletion:(void(^)(NSArray<HotTopic *>*topics))completion;
@end
