//
//  AccountModel.h
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *headPic;
@property (nonatomic,assign) BOOL type;
+ (NSMutableArray*)modelReadPlist:(NSString*)plist;
@end
