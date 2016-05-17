//
//  Recom.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recom : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *iconUrl;
+(instancetype)recomWithDic:(NSDictionary*)dic;
+ (NSArray*)allRecoms;
@end
