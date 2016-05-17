//
//  Mine.h
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mine : NSObject
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subTitle;
@property (nonatomic,retain) NSString *imageName;
@property (nonatomic,assign) BOOL needLogin;
@property (nonatomic,copy) NSString *login;
+ (NSArray*)allData;
@end
