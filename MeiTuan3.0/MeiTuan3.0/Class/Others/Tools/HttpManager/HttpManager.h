//
//  HttpManager.h
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject
//http get
+ (void)httpGet:(nullable NSString*)urlStr parameters:(nullable id)parameters progress:(nullable void(^)(NSProgress *_Nonnull progress))progress completion:(nullable void(^)( NSError *_Nonnull error,NSDictionary *_Nonnull dic))completion;
//http post
+ (void)httpPost:(nullable NSString*)urlStr parameters:(nullable id)parameters progress:(nullable void(^)(NSProgress *_Nonnull progress))progress completion:(nullable void(^)(NSError *_Nonnull error,NSDictionary *_Nonnull dic))completion;
//monitor netState
+ (void)httpNetWorkReachabilityWithCompletion:(nullable void(^)(BOOL state))completion;
@end
