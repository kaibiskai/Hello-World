//
//  CityHead.m
//  MeiTuan3.0
//
//  Created by student on 16/5/13.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "CityHead.h"
#import "CityView.h"
#define kButtonWidth (kScreenWidth-5*kCut)/3

@interface CityHead ()

@end
@implementation CityHead
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headers = [NSMutableArray array];
        self.titles = [NSMutableArray array];
        [self locationView];
        [self lastestView];
        [self hotView];
    }
    return self;
}
- (void)hotView {
    NSArray *arr = [CityA hotCitys];
    CityView *view = [[CityView alloc]initWithAreas:arr];
    [self.headers addObject:view];
    [self.titles addObject:@"热门城市"];
}
- (void)lastestView {
    NSArray *arr = [CityA lastestCitys];
    CityView *view = [[CityView alloc]initWithAreas:arr];
    [self.headers addObject:view];
    [self.titles addObject:@"最近访问城市"];
}
- (void)locationView {
    CityA *city = [CityA locationCity];
    if (city) {
        CityView *view = [[CityView alloc]initWithAreas:@[city]];
        [self.headers addObject:view];
        [self.titles addObject:@"定位城市"];
    }
}
@end
