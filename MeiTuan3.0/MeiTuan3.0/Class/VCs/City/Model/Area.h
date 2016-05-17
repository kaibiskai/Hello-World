//
//  Area.h
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger cityID;
@end
@interface City : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger proID;
@property (readonly,nonatomic,retain) NSArray *areas;
+ (instancetype)cityWithCityName:(NSString*)name;
@end
@interface Province : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger ID;
@property (readonly,nonatomic,retain) NSArray *citys;
+ (void)allCityData;
@end