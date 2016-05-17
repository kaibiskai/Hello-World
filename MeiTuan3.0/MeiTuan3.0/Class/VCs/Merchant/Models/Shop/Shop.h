//
//  Shop.h
//  MeiTuan
//
//  Created by student on 16/5/6.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject
@property (copy,nonatomic) NSString*frontImg;
@property (assign,nonatomic) NSInteger avgPrice;
@property (assign,nonatomic) CGFloat avgScore;
@property (assign,nonatomic) NSInteger markNumbers;
@property (copy,nonatomic) NSString *name;
@property (assign,nonatomic) BOOL isWaimai;
@property (assign,nonatomic) BOOL isHot;
@property (assign,nonatomic) BOOL hasGroup;
@property (copy,nonatomic) NSString *areaName;
@property (copy,nonatomic) NSString *cateName;
+(void)shopRequestWithUrl:(NSString*)urlStr completion:(void(^)(NSArray<Shop *>*shops))completion;

@end
