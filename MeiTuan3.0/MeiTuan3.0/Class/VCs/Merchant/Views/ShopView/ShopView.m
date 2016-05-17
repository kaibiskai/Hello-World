//
//  ShopView.m
//  MeiTuan
//
//  Created by student on 16/5/6.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "ShopView.h"
#import "ShopTableViewCell.h"
#import "LocationManager.h"
@interface ShopView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataArr;
@property (copy,nonatomic) void(^block)(Shop*shop);
@property (copy,nonatomic) void(^reload)(void);
@property (copy,nonatomic) void(^location)(NSString*);
@property (assign,nonatomic) BOOL load;
@property (retain,nonatomic) UILabel *label;
@property (retain,nonatomic) LocationManager *manager;
@end
@implementation ShopView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kNavHeight+kCellHeight, kScreenWidth, kScreenHeight-kNavHeight-kCellHeight-kTabHeight);
        self.dataArr = [NSMutableArray array];
        [self createTableView];
    }
    return self;
}
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[ShopTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
#pragma mark--tableView.dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.shop = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self headView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeight;
}
#pragma mark--tableView.delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.block (self.dataArr[indexPath.row]);
}
- (void)shopViewDidSelectShop:(void(^)(Shop *shop))shop {
    if (shop) {
        self.block = shop;
    }
}
#pragma mark--上拉加载scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    NSIndexPath *indexPath = [arr lastObject];
    if (indexPath.row==self.dataArr.count-1) {
        if (!self.load) {
            KSLog(@"加载更多");
            self.reload ();
            self.load = !self.load;
        }
    }
}
- (void)reloadMoreDataHandle:(void(^)(void))handle location:(void(^)(NSString *name))location {
    if (handle) {
        self.reload = handle;
    }
    if (location) {
        self.location = location;
    }
}

#pragma mark--reload
- (void)reloadDataWithArr:(NSArray*)arr {
    [self.dataArr addObjectsFromArray:arr];
    [self.tableView reloadData];
    if (self.load) {
        self.load = !self.load;
    }
}
#pragma mark--headView
- (UIView*)headView {
    UIView *view = [[UIView alloc]init];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(kCut, 0, self.width-kCellHeight, kCellHeight)];
   CityA *city = [CityA currentCity];
    self.label.text = [NSString stringWithFormat:@"当前位置:%@",city.name];
    [view addSubview:self.label];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"]];
    imageView.frame = CGRectMake(self.width-kCellHeight, (kCellHeight-2*kCut)/2, 2*kCut, 2*kCut);
    [view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.width, kCellHeight);
    [button addTarget:self action:@selector(locationRefresh) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
#pragma mark--判断是否需要第一次请求数据
- (BOOL)isNeedRequest {
    if (self.dataArr.count>0) {
        return NO;
    }
    return YES;
}
#pragma mark--区头点击事件
-  (void)locationRefresh {
    KSLog(@"定位刷新");
    self.manager = [[LocationManager alloc]init];
    [self.manager locationWithCompletion:^(NSString *cityName) {
        CityA *city =[CityA currentCity];
        if ([cityName containsString: city.name]) {
            return ;
        }
        NSString *name = [cityName substringToIndex:cityName.length-1];
        CityA *aCity = [[CityA selectCitysWithSearchText:name]firstObject];
                CityA *location = [CityA locationCity];
                if (![aCity.name isEqualToString:location.name]) {
                    aCity.location = YES;
                    location.location = NO;
                    self.label.text = [NSString stringWithFormat:@"当前位置:%@",aCity.name];
                    self.location(aCity.name);
                }
                aCity.lastest = YES;
    }];
    
}
@end
