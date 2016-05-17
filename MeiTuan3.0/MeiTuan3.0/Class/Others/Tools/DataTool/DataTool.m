//
//  DataTool.m
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "DataTool.h"
#import "FMDB.h"

static FMDatabase *__db = nil;
@implementation DataTool
#pragma mark--CreateDatabase
+ (void)dataToolCreateDatabase {
    if (__db == nil) {
        __db = [[FMDatabase alloc]initWithPath:[NSString pathForFileUnderDocuWith:@"database.sqlite"]];
        KSLog(@"%@",[NSString pathForFileUnderDocuWith:@"database.sqlite"]);
    }
    [__db open];
}
#pragma mark--createTable
+ (void)dataToolCreateTableForModel:(Class)className withAttributes:(NSDictionary*)dic {
    
    NSInteger count = 0;
    NSString *sqStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement not null unique",NSStringFromClass(className)];
    while (count<dic.count) {
        NSString *key = dic.allKeys[count];
        NSString *value = dic[key];
        if (count== dic.count-1) {
            sqStr =[sqStr stringByAppendingString:[NSString stringWithFormat:@",%@ %@)",key,value]];
        }else sqStr =[sqStr stringByAppendingString:[NSString stringWithFormat:@",%@ %@",key,value]];
        count++;
    }
    [__db executeUpdate:sqStr];
}
#pragma mark--insert into table
+ (void)dataToolInsertTable:(Class)className withAttributes:(NSDictionary*)dic {
    NSString *sqStr = [NSString stringWithFormat:@"insert into %@",NSStringFromClass(className)];
    NSString *keyStr = @"(";
    NSString *valueStr = @"(";
    for (int i =0; i<dic.count; i++) {
        NSString *key = dic.allKeys[i];
        id value = dic[key];
        if (i == dic.count-1) {
                keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%@)",key]];
                if ([value isKindOfClass:[NSNumber class]]) {
                    valueStr = [valueStr stringByAppendingString:[NSString stringWithFormat:@"%@)",value]];
                }else {
                    valueStr = [valueStr stringByAppendingString:[NSString stringWithFormat:@"'%@')",value]];
                }
        }else {
                keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%@,",key]];
                if ([value isKindOfClass:[NSNumber class]]) {
                    valueStr = [valueStr stringByAppendingString:[NSString stringWithFormat:@"%@,",value]];
                }else {
                    valueStr = [valueStr stringByAppendingString:[NSString stringWithFormat:@"'%@',",value]];
                }
            }
    }
    sqStr = [NSString stringWithFormat:@"%@ %@ values %@",sqStr,keyStr,valueStr];
    [__db executeUpdate:sqStr];
}
#pragma mark--select from table
+ (NSMutableArray*)dataToolSelectFromTable:(nonnull Class)className withCondition:(nullable NSString*)condition setNext:(void(^)(FMResultSet*set,NSMutableArray *dataArr))next {
    NSString *sqStr = [NSString stringWithFormat:@"select * from %@",NSStringFromClass(className)];
    if (condition) {
        sqStr = [sqStr stringByAppendingString:[NSString stringWithFormat:@" where %@",condition]];
    }
    FMResultSet *set = [__db executeQuery:sqStr];
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    while ([set next]) {
        if (next) {
            next(set,dataArr);
        }
    }
    [set close];
    return dataArr;
}
#pragma mark--upDate table
+ (void)dataToolUpDateTable:(nonnull Class)className withCondition:(nonnull NSString*)condition {
    NSString *sqStr = [NSString stringWithFormat:@"update %@ set %@",NSStringFromClass(className),condition];
    [__db executeUpdate:sqStr];
}
#pragma mark--delete data from table
+ (void)dataToolDeleteDataFromTable:(nonnull Class)className withCondition:(nullable NSString*)condition {
    NSString *sqStr = [NSString stringWithFormat:@"delete from %@",NSStringFromClass(className)];
    if (condition) {
        sqStr = [sqStr stringByAppendingString:[NSString stringWithFormat:@" where %@",condition]];
    }
    [__db executeUpdate:sqStr];
}
@end
