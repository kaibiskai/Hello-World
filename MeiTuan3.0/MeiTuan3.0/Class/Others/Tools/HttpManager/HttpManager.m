//
//  HttpManager.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HttpManager.h"
#import "AFNetworking.h"
#import "KSHTTPManager.h"
static NSString *const baseUrl = @"http://www.baidu.com";
@implementation HttpManager
#pragma mark--get
+ (void)httpGet:(NSString*)urlStr parameters:(nullable id)parameters progress:(void(^)(NSProgress *_Nonnull progress))progress completion:(void(^)( NSError *error,NSDictionary *dic))completion {
        KSHTTPManager *manager = [KSHTTPManager sharedManager];
        [manager GET:urlStr parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                completion(nil,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(error,nil);
            }
        }];
}
#pragma mark--post
+ (void)httpPost:(NSString*)urlStr parameters:(nullable id)parameters progress:(void(^)(NSProgress *_Nonnull progress))progress completion:(void(^)(NSError * error,NSDictionary * dic))completion {
        KSHTTPManager *manager = [KSHTTPManager sharedManager];
        [manager POST:urlStr parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (completion) {
                completion(nil,responseObject);;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (completion) {
                completion(error,nil);;
            }
        }];
}
#pragma mark--netReachability
+ (void)httpNetWorkReachabilityWithCompletion:(void(^)(BOOL state))completion {
    __block BOOL netState = NO;
#if 0
    AFNetworkReachabilityManager *manager =[AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
                break;
            default:
                break;
        }
        if (completion) {
            completion(netState);
        }
    }];
    [manager startMonitoring];
#else
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
//    __block AFHTTPSessionManager *weakManager = manager;
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:YES];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [operationQueue setSuspended:NO];
                netState = NO;
            default:
                break;
        }
//        [weakManager.reachabilityManager stopMonitoring];
        if (completion) {
            completion(netState);
        }
    }];
    [manager.reachabilityManager startMonitoring];
#endif
}
@end
