//
//  JsonManager.h
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject
//read json for resource
+ (NSDictionary*)jsonWithContentsOfFileName:(NSString*)name;
//read customObject plist
+ (instancetype)plistWithContentsOfFileName:(NSString*)name;
//write customObiect plist
+ (void)plist:(id)plist writeToFileName:(NSString*)name;
//read normal plist
+  (NSArray*)normalPlistWithContentsOfFileName:(NSString*)name;
@end
