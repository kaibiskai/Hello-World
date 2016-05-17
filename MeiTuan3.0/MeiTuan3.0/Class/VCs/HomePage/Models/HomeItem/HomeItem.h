//
//  HomeItem.h
//  BeautifulGroup
//
//  Created by student on 16/4/22.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeItem : NSObject
@property (copy,nonatomic) NSString *imageUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *mainMessage;
@property (nonatomic,copy) NSString *mainMessage2;
@property (nonatomic,copy) NSString *subMessage;
@property (nonatomic,copy) NSString *topRightInfo;
@property (nonatomic,copy) NSString *bottomRightInfo;
@property (nonatomic,copy) NSString *subTag;
+ (instancetype)itemWithDic:(NSDictionary*)dic;
+ (NSArray*)lastModels;
+ (void)itemRequestWithCompletion:(void(^)(NSArray<HomeItem *>*models))completion;
@end
/*
 "imageUrl": "http://p0.meituan.net/w.h/deal/__33903250__8032802.jpg",
 "imageTag": "3",
 "title": "优乐自动餐厅",
 "subTitle": "[多城市] 单人自助，午晚餐通用，免费WiFi",
 "mainMessage": "¥",
 "mainMessage2": "37.5",
 "subMessage": "门市价:¥43",
 "topRightInfo": "6.5km",
 "bottomR
 */