//
//  Area.m
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "Area.h"

@implementation Area
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"areaName"];
        self.ID = [dic[@"id"]integerValue];
    }
    return self;
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.name = [set stringForColumn:@"name"];
        self.ID = [set intForColumn:@"areaID"];
        self.cityID = [set intForColumn:@"cityID"];
    }
    return self;
}
+ (void)createTable {
    [DataTool dataToolCreateTableForModel:self withAttributes:@{@"name":@"text",@"areaID":@"integer",@"cityID":@"integer"}];
}
- (void)insertData {
    [DataTool dataToolInsertTable:[super class] withAttributes:@{@"name":self.name,@"areaID":[NSNumber numberWithInteger:self.ID],@"cityID":[NSNumber numberWithInteger:self.cityID]}];
}
@end
@implementation City
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"cityName"];
        self.ID = [dic[@"id"]integerValue];
        [Area createTable];
        NSArray *arr =dic[@"arealist"];
        for (int i =0; i< arr.count; i++) {
            NSDictionary *subDic = arr[i];
            Area *area = [[Area alloc]initWithDic:subDic];
            area.cityID = self.ID;
            [area insertData];
        }
    }
    return self;
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.name = [set stringForColumn:@"name"];
        self.ID = [set intForColumn:@"cityID"];
        self.proID = [set intForColumn:@"proID"];
    }
    return self;
}
+ (void)createTable {
    [DataTool dataToolCreateTableForModel:self withAttributes:@{@"name":@"text",@"cityID":@"integer",@"proID":@"integer"}];
}
- (void)insertData {
    [DataTool dataToolInsertTable:[super class] withAttributes:@{@"name":self.name,@"cityID":[NSNumber numberWithInteger:self.ID],@"proID":[NSNumber numberWithInteger:self.proID]}];
}
-(NSArray*)areas {
    NSArray *arr = [DataTool dataToolSelectFromTable:[Area class] withCondition:[NSString stringWithFormat:@"cityID=%ld",self.ID] setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        Area *area = [[Area alloc]initWithFMSet:set];
        [dataArr addObject:area];
    }];
    return arr;
}
+ (instancetype)cityWithCityName:(NSString*)name {
    NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:[NSString stringWithFormat:@"name like '%@%%'",name] setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        City *city = [[City alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    return arr.firstObject;
}
@end
@implementation Province
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"provinceName"];
        self.ID = [dic[@"id"]integerValue];
        [City createTable];
        NSArray *arr =dic[@"citylist"];
        for (int i =0; i< arr.count; i++) {
            NSDictionary *subDic = arr[i];
            City *city = [[City alloc]initWithDic:subDic];
            city.proID = self.ID;
            [city insertData];
        }
    }
    return self;
}
- (instancetype)initWithFMSet:(FMResultSet*)set
{
    self = [super init];
    if (self) {
        self.name = [set stringForColumn:@"name"];
        self.ID = [set intForColumn:@"proID"];
    }
    return self;
}
+ (void)createTable {
    [DataTool dataToolCreateTableForModel:self withAttributes:@{@"name":@"text",@"proID":@"integer"}];
}
- (void)insertData {
    [DataTool dataToolInsertTable:[super class] withAttributes:@{@"name":self.name,@"proID":[NSNumber numberWithInteger:self.ID]}];
}
+(NSArray*)allProvinces {
  NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:nil setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
      Province *pro = [[Province alloc]initWithFMSet:set];
      [dataArr addObject:pro];
  }];
    return arr;
}
-(NSArray*)citys {
    NSArray *arr = [DataTool dataToolSelectFromTable:[City class] withCondition:[NSString stringWithFormat:@"proID=%ld",self.ID] setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        City *city = [[City alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    return arr;
}
+ (void)allCityData {
    NSArray *arr =[NSArray arrayWithContentsOfFile:[NSString pathForResource:@"citydata.plist"]];
    [self createTable];
    for (NSDictionary *dic in arr) {
        Province *pro=[[self alloc]initWithDic:dic];
        [pro insertData];
    }
}
@end