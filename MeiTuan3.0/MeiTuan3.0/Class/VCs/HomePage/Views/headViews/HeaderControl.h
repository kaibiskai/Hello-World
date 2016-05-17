//
//  HeaderControl.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recom;
@interface HeaderControl : NSObject
@property (retain,nonatomic) NSMutableArray *headers;
//- (instancetype)initWithRecomBlock:(void(^)(Recom*recom))recomBlock;
- (instancetype)initWithRecomBlock:(void(^)(Recom*recom))recomBlock requestBlock:(void(^)(NSMutableArray*))requestBlock;
@end
