//
//  Cate.h
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cate : NSObject
@property (assign,nonatomic) BOOL selected;
@property (nonatomic,copy) NSString *name;
@property (copy,nonatomic) NSString *iconUrl;
@property (nonatomic,retain) NSMutableArray *subLists;
+ (NSArray *)allCates;
@end
@interface SubCate : NSObject
- (instancetype)initWithDic:(NSDictionary*)dic;
@property (assign,nonatomic) BOOL selected;
@property (nonatomic,copy) NSString *name;
@property (assign,nonatomic) NSInteger count;
@end