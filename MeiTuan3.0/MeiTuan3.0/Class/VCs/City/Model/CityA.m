//
//  CityB.m
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "CityA.h"
@interface CityA ()
@end
@implementation CityA
- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (self.pinyin) {
            self.firstLetter = [[self.pinyin substringToIndex:1] uppercaseString];
        }
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
    if ([key isEqualToString:@"cityName"]) {
        [self setValue:value forKey:@"name"];
    }
}
- (instancetype)initWithFMSet:(FMResultSet *)set
{
    self = [super init];
    if (self) {
        self.pinyin = [set stringForColumn:@"pinyin"];
        self.name = [set stringForColumn:@"name"];
        self.lat = [set intForColumn:@"lat"];
        self.lng = [set intForColumn:@"lng"];
        self.firstLetter = [set stringForColumn:@"firstLetter"];
        self.ID = [set intForColumn:@"cityID"];
        self.hot = [set boolForColumn:@"hot"];
        self.location = [set boolForColumn:@"location"];
    }
    return self;
}
+(void)createNormalTable {
    [DataTool dataToolCreateTableForModel:self withAttributes:@{@"cityID":KS_INTEGER,@"name":KS_TEXT,@"pinyin":KS_TEXT,@"lat":KS_TEXT,@"lng":KS_TEXT,@"firstLetter":KS_TEXT,@"hot":KS_BOOLEAN,@"location":KS_BOOLEAN}];
}
-(void)insertData {
    [DataTool dataToolInsertTable:[super class] withAttributes:@{@"cityID":@(self.ID),@"name":self.name,@"pinyin":self.pinyin,@"lat":@(self.lat),@"lng":@(self.lng),@"firstLetter":self.firstLetter,@"hot":@(0),@"location":@(0)}];
}
-(void)setHot:(BOOL)hot {
    if (_hot != hot) {
        _hot = hot;
        [DataTool dataToolUpDateTable:[super class] withCondition:[NSString stringWithFormat:@"hot=%d where name='%@'",_hot,self.name]];
    }
}
-(void)setLocation:(BOOL)location {
    if (_location != location) {
        _location = location;
        [DataTool dataToolUpDateTable:[super class] withCondition:[NSString stringWithFormat:@"location=%d where name='%@'",_location,self.name]];
    }
}
+ (instancetype)locationCity {
    NSArray * arr = [DataTool dataToolSelectFromTable:self withCondition:@"location=1" setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        CityA *city = [[CityA alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    if (arr.count>0) {
        return arr.firstObject;
    }
    return nil;
}
+ (NSArray*)hotCitys {
    NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:@"hot=1" setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        CityA *city = [[CityA alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    return arr;
}
+ (void)allCitysSortByFirstLetterWithCompletion:(void(^)(NSArray<NSArray<CityA*>*>*dataArr,NSArray<NSString*>*titles))completion {
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (char i = 'A'; i <= 'Z'; i++) {
        NSArray *arr = [DataTool dataToolSelectFromTable:self withCondition:[NSString stringWithFormat:@"firstLetter='%c'",i] setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
            CityA *city = [[CityA alloc]initWithFMSet:set];
            [dataArr addObject:city];
        }];
        if (arr.count>0) {
            [dataArr addObject:arr];
            [titles addObject:[NSString stringWithFormat:@"%c",i]];
        }
    }
    if (completion) {
        completion(dataArr,titles);
    }
}

+(void)allCitysData {
    [self createNormalTable];
    NSArray *arr = [NSArray arrayWithContentsOfFile:[NSString pathForResource:@"city.plist"]];
    for (NSDictionary *dic in arr) {
        CityA *city = [[CityA alloc]initWithDic:dic];
        [city insertData];
    }
    NSArray *hots = [NSArray arrayWithContentsOfFile:[NSString pathForResource:@"hotCity.plist"]];
    for (NSDictionary *dic in hots) {
        CityA *city = [[CityA alloc]initWithDic:dic];
        city.hot = YES;
    }
    [self createTable];
}
+ (instancetype)defaultCity {
    NSArray * arr = [DataTool dataToolSelectFromTable:self withCondition:@"name='北京'" setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        CityA *city = [[CityA alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    return arr.firstObject;
}
+ (void)createTable {
    [DataTool dataToolCreateTableForModel:[LastestCity class] withAttributes:@{@"cityID":KS_INTEGER,@"name":KS_TEXT,@"pinyin":KS_TEXT,@"lat":KS_TEXT,@"lng":KS_TEXT,@"firstLetter":KS_TEXT,@"hot":KS_BOOLEAN,@"location":KS_BOOLEAN}];
    [[self defaultCity] insertLastData];
}
- (void)insertLastData {
    [DataTool dataToolInsertTable:[LastestCity class] withAttributes:@{@"cityID":@(self.ID),@"name":self.name,@"pinyin":self.pinyin,@"lat":@(self.lat),@"lng":@(self.lng),@"firstLetter":self.firstLetter,@"hot":@(self.hot),@"location":@(self.location)}];
}
-(void)setLastest:(BOOL)lastest {
    if (lastest) {
        NSArray *arr = [DataTool dataToolSelectFromTable:[LastestCity class] withCondition:[NSString stringWithFormat:@"name='%@'",self.name] setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
            CityA *city = [[CityA alloc]initWithFMSet:set];
            [dataArr addObject:city];
        }];
        if (arr) {
            [DataTool dataToolDeleteDataFromTable:[LastestCity class] withCondition:[NSString stringWithFormat:@"name='%@'",self.name]];
        }
        [self insertLastData];
    }
}
+ (NSArray*)lastestCitys {
    NSArray *arr = [DataTool dataToolSelectFromTable:[LastestCity class] withCondition:nil setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        CityA *city = [[CityA alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSInteger i = arr.count-1; i>=0; i--) {
        CityA *city = arr[i];
        [dataArr addObject:city];
        if (i==arr.count-3) {
            break;
        }
    }
    return dataArr;
}
+ (instancetype)currentCity {
    NSArray *arr = [self lastestCitys];
    return [arr firstObject];
}
+ (NSArray*)selectCitysWithSearchText:(NSString*)searchText {
    if (searchText.length==0) {
        return [NSArray array];
    }
    BOOL ret = [searchText isChinese];
    NSString *str;
    if (ret) {
        str = [NSString stringWithFormat:@"name like '%%%@%%'",searchText];
    }else {
        str = [NSString stringWithFormat:@"pinyin like '%@%%'",searchText];

    }
   return  [DataTool dataToolSelectFromTable:self withCondition:str setNext:^(FMResultSet * _Nonnull set, NSMutableArray * _Nonnull dataArr) {
        CityA *city = [[CityA alloc]initWithFMSet:set];
        [dataArr addObject:city];
    }];
}
@end
@implementation LastestCity


@end