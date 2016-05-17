//
//  DataTool.h
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KS_TEXT  @"text"
#define KS_INTEGER  @"integer"
#define KS_BOOLEAN  @"boolean"
@class FMResultSet;
@interface DataTool : NSObject
// called in application.m
+ (void)dataToolCreateDatabase;

//create table with attributes:{@"name":@"text",····}
+ (void)dataToolCreateTableForModel:(nonnull Class)className withAttributes:(nonnull NSDictionary*)dic;

//insert table with attributes:{@"name":@"zhangsan",····} ,if value iskindofclass cannot be nil
+ (void)dataToolInsertTable:(nonnull Class)className withAttributes:(nonnull NSDictionary*)dic;

//select from table ,if condition is nil,select all
+ (nullable NSMutableArray*)dataToolSelectFromTable:(nonnull Class)className withCondition:(nullable NSString*)condition setNext:(nullable void(^)(FMResultSet*_Nonnull set,NSMutableArray *_Nonnull dataArr))next;

//update table with condition:name='zhangsan' where id=5
+ (void)dataToolUpDateTable:(nonnull Class)className withCondition:(nonnull NSString*)condition;

//delete table data with condition:name = 'zhangsan'
+ (void)dataToolDeleteDataFromTable:(nonnull Class)className withCondition:(nullable NSString*)condition;

@end
