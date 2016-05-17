//
//  CityB.h
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityA : NSObject
@property (copy,nonatomic) NSString *pinyin;
@property (copy,nonatomic) NSString *name;
@property (assign,nonatomic) CGFloat lat;
@property (assign,nonatomic) CGFloat lng;
@property (copy,nonatomic) NSString *firstLetter;
@property (nonatomic,assign) NSInteger ID;
@property (readonly,assign,nonatomic) BOOL hot;
//
@property (assign,nonatomic) BOOL location;
//this property only can  set be YES;
@property (assign,nonatomic) BOOL lastest;
//get locationCity
+ (instancetype)locationCity;

//get all citys with firstLetter from A-Z
+ (void)allCitysSortByFirstLetterWithCompletion:(void(^)(NSArray<NSArray<CityA*>*>*dataArr,NSArray<NSString*>*titles))completion;

//insert data
+(void)allCitysData;

+ (NSArray*)hotCitys;
+ (NSArray*)lastestCitys;

+ (instancetype)currentCity;

+ (NSArray*)selectCitysWithSearchText:(NSString*)searchText;
//this method can olny called once;
+ (void)createTable;
@end
@interface LastestCity : CityA

@end