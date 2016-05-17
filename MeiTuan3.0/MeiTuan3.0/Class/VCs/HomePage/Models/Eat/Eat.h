//
//  Eat.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Eat : NSObject
@property (nonatomic,copy) NSString*imageurl;
@property (nonatomic,copy) NSString *maintitle;
@property (nonatomic,copy) NSString *deputytitle;
@property (nonatomic,assign) NSInteger position;
+ (instancetype)eatWithDic:(NSDictionary*)dic;
- (instancetype)initWithFMSet:(FMResultSet*)set;
+ (NSArray*)lastEatPlays;
+ (void)eatRequestWithCompletion:(void(^)(NSArray<Eat *>*eats))completion;
@end
