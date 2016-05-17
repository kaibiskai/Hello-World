//
//  JsonManager.m
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager
+ (NSDictionary*)jsonWithContentsOfFileName:(NSString*)name {
   name = [NSString stringWithFormat:@"%@.json",name];
    NSString *path = [NSString pathForResource:name];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return dic;
}
//wirte to file 对象序列化
+ (instancetype)plistWithContentsOfFileName:(NSString*)name {
    name = [NSString stringWithFormat:@"%@.plist",name];
    NSString *path = [NSString pathForFileUnderDocuWith:name];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id file = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return file;
}
+ (void)plist:(id)plist writeToFileName:(NSString*)name {
    name = [NSString stringWithFormat:@"%@.plist",name];
    NSString *path = [NSString pathForFileUnderDocuWith:name];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:plist];
    [data writeToFile:path atomically:YES];
}
//read normal plist
+  (NSArray*)normalPlistWithContentsOfFileName:(NSString*)name {
    name = [NSString stringWithFormat:@"%@.plist",name];
    NSString *path = [NSString pathForResource:name];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return arr;
}
@end
