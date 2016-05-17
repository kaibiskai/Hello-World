//
//  Misc.h
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Misc : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *subTitle;
@property (assign,nonatomic)BOOL status;
+ (NSArray*)allData;
@end
