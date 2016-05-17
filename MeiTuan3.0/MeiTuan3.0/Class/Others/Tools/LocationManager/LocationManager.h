//
//  LocationManager.h
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject
- (void)locationWithCompletion:(void(^)(NSString*cityName))completion;
@end
