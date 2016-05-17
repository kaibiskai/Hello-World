//
//  MerchantViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MerchantViewController.h"
#import "ShopView.h"
#import "Shop.h"
#import "Cate.h"
#import "SortView.h"
#import "AreaView.h"
#import "GoodView.h"
@interface MerchantViewController ()
@property (nonatomic,retain) NSArray *shopUrls,*sorts;
@property (assign,nonatomic) NSInteger index,lastButtonTag;
@property (assign,nonatomic) BOOL request;
@property (retain,nonatomic) NSMutableArray *shopViews,*sortViews,*buttons;
@property (retain,nonatomic) NSMutableArray *dataArrs;
@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNav];
    [self createSortBar];
    [self createShopViews];
}
#pragma mark--setUpNav
- (void)setUpNav {
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"全部商家",@"优惠商家"]];
    segment.tintColor = kDefaulsColor;
    [segment addTarget:self action:@selector(segmentChangerd:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(leftBarButtonClick:) withTitle:nil imageNamed:@"icon_homepage_map" type:UIButtonImageLeft];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(rightBarButtonClick:) withTitle:nil imageNamed:@"icon_homepage_searchbar_left" type:UIButtonImageLeft];
    self.sorts = @[@[@"智能排序",@"好评优先",@"距离最近",@"人均最低"],@[@"智能排序",@"好评优先",@"距离最近",@"优惠价最低"]];
}
#pragma mark--NavButtonClick
- (void)leftBarButtonClick:(UIButton*)sender {
    
}
- (void)rightBarButtonClick:(UIButton *)sender {
    
}
- (void)segmentChangerd:(UISegmentedControl*)sender {
    ShopView *shopView = self.shopViews[self.index];
    [shopView removeFromSuperview];
    self.index = sender.selectedSegmentIndex;
    GoodView *goodView = self.sortViews[2];
    goodView.dataArr = self.sorts[self.index];
    ShopView *nextView = self.shopViews[self.index];
    [self.view addSubview:nextView];
    if ([nextView isNeedRequest]) {
        [self requestData];
    }
    if (self.lastButtonTag>=0) {
        UIButton *button = self.buttons[self.lastButtonTag];
        [self sortButtonClick:button];
    }
}
#pragma mark--sortBar
- (void)createSortBar {
    self.lastButtonTag = -1;
    NSArray *arr = @[@"全部分类",@"全城",@"智能排序"];
    self.buttons = @[].mutableCopy;
    for (int i =0; i<arr.count; i++) {
        UIButton *button = [UIButton buttonWithTitle:arr[i] imageNamed:nil target:self action:@selector(sortButtonClick:)];
        button.frame = CGRectMake(kScreenWidth/arr.count*i, kNavHeight, kScreenWidth/arr.count, kCellHeight);
        button.tag = i;
        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaulsColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"shopping_mall_btn_bg_press"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [self.buttons addObject:button];
    }
    [self createSoreViews];
}
#pragma mark--createSoreViews
- (void)createSoreViews {
    self.sortViews = @[].mutableCopy;
    SortView *sortView = [[SortView alloc]init];
    UIButton *sortButton = self.buttons.firstObject;
    [sortView SortViewDidSelectItemCompletion:^(NSString *name) {
        [sortButton setTitle:name forState:UIControlStateNormal];
        sortButton.selected = NO;
        self.lastButtonTag = -1;
    } dismiss:^{
        sortButton.selected = NO;
        self.lastButtonTag = -1;
    }];
    [self.sortViews addObject:sortView];
    AreaView *areaView = [[AreaView alloc]init];
    CityA *aCity = [CityA currentCity];
    areaView.city = [City cityWithCityName:aCity.name];
    UIButton *areaButton = self.buttons[1];
    [areaView viewDidSelectItemCompletion:^(NSString *name) {
        [areaButton setTitle:name forState:UIControlStateNormal];
        areaButton.selected = NO;
        self.lastButtonTag = -1;
    } dismiss:^{
        areaButton.selected = NO;
        self.lastButtonTag = -1;
    }];
    [self.sortViews addObject:areaView];
    GoodView *goodView = [[GoodView alloc]init];
    UIButton *goodButton = self.buttons[2];
    goodView.dataArr = self.sorts[self.index];
    [goodView viewDidSelectItemCompletion:^(NSString *name) {
        [goodButton setTitle:name forState:UIControlStateNormal];
        goodButton.selected = NO;
        self.lastButtonTag = -1;
    } dismiss:^{
        goodButton.selected = NO;
        self.lastButtonTag = -1;
    }];
    [self.sortViews addObject:goodView];
}
#pragma mark--sortButtonClick
- (void)sortButtonClick:(UIButton*)sender {
    UIView *view = self.sortViews[sender.tag];
    if (sender.selected) {
        [view removeFromSuperview];
        sender.selected = NO;
        self.lastButtonTag = -1;
    }else {
        [self.view addSubview:view];
        sender.selected = YES;
        if (self.lastButtonTag>=0) {
            UIButton *button = self.buttons[self.lastButtonTag];
            button.selected = NO;
            UIView *lastView = self.sortViews[self.lastButtonTag];
            [lastView removeFromSuperview];
        }
        self.lastButtonTag = sender.tag;
    }
}
#pragma mark--createShopViews
- (void)createShopViews {
    self.shopUrls = @[MT_MER_ShopsUrl,MT_MER_DiscountShopsUrl];
    self.shopViews = @[].mutableCopy;
    for (int i = 0; i<self.shopUrls.count; i++) {
        ShopView *shopView = [[ShopView alloc]init];
        [shopView reloadMoreDataHandle:^{
            [self requestData];
        } location:^(NSString *name) {
            AreaView *areaView = self.sortViews[1];
            areaView.city = [City cityWithCityName:name];
        }];
        [shopView shopViewDidSelectShop:^(Shop *shop) {
         //push到商品展示界面
        }];
        [self.shopViews addObject:shopView];
    }
    [self.view addSubview:self.shopViews[self.index]];
    [self requestData];
}
#pragma mark--requestData
- (void)requestData {
    [Shop shopRequestWithUrl:self.shopUrls[self.index] completion:^(NSArray<Shop *> *shops) {
        ShopView *shopView = self.shopViews[self.index];
        [shopView reloadDataWithArr:shops];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
