//
//  KSHTTPManager.h
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface KSHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end
