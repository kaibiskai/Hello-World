//
//  HomeViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HeaderControl.h"
#import "GuideView.h"
#import "RushView.h"
#import "EatView.h"
#import "Rush.h"
#import "Eat.h"
#import "HotTopic.h"
#import "HotChannelView.h"
#import "HomeItem.h"
#import "QRCodeViewController.h"
#import "CityViewController.h"
#import "LocationManager.h"
@interface HomeViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *dataArr;
@property (retain,nonatomic) HeaderControl *head;
@property (nonatomic,retain) UISearchBar *searchBar;
@property (nonatomic,retain) LocationManager *manager;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *guide = [[NSUserDefaults standardUserDefaults]objectForKey:@"GUIDEVERSION"];
    if ([guide isEqualToString:kVERSION]) {
        [self setUpNav];
        [self createTableView];
        [self location];
    }else {
        [self launchGuideView];
    }
}
#pragma mark--location 
- (void)location {
    self.manager = [[LocationManager alloc]init];
    [self.manager locationWithCompletion:^(NSString *cityName) {
        CityA *city =[CityA currentCity];
        if ([cityName containsString: city.name]) {
            return ;
        }
        NSString *name = [cityName substringToIndex:cityName.length-1];
        CityA *aCity = [[CityA selectCitysWithSearchText:name]firstObject];
        [OtherTool otherToolFromVC:self presentAlertWithMessage:[NSString stringWithFormat:@"当前定位城市为%@，是否进行切换？",cityName] completion:^(BOOL cancel) {
            if (!cancel) {
                CityA *location = [CityA locationCity];
                if (![aCity.name isEqualToString:location.name]) {
                    aCity.location = YES;
                    location.location = NO;
                }
                aCity.lastest = YES;
                [self.navigationItem.leftBarButtonItem setTitle:name forState:UIControlStateNormal];
            }
        } alertType:UIAlertButtonTypeSureAndCancel];
    }];
}
#pragma mark--guideView
-(void)launchGuideView {
    GuideView *guideView = [[GuideView alloc]initWithImages:@[@"guide_first",@"guide_second",@"guide_third"]];
    [guideView showSelfWithCompletion:^{
        [self setUpNav];
        [self createTableView];
        [self location];
    }];
}
#pragma mark--setUpNav
- (void)setUpNav {
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.placeholder = @"请输入商家、分类或商圈";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem itemsAddTarget:self action:@selector(rightBarButtonClick:) withTitles:nil imageNamed:@[@"icon_homepage_message",@"icon_homepage_quickentry"]];
}

#pragma mark--leftBarButtonClick
- (void)leftBarButtonClick:(UIButton *)sender {
    //push到城市界面
    CityViewController *VC = [[CityViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--rightBarButtonClick
- (void)rightBarButtonClick:(UIButton*)sender {
    //0.登录状态下push到消息界面 未登录状态下模态到登录界面
    if (sender.tag == 0) {
        if (![User currentUser]) {
          [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
        }
        
    }
    //1.扫描二维码
    if (sender.tag==1) {
        QRCodeViewController *VC = [[QRCodeViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark--searchBar.delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //push到搜索界面
    return NO;
}
#pragma mark--createTableView
- (void)createTableView {
    self.dataArr = @[].mutableCopy;
    self.tableView = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.head = [[HeaderControl alloc]initWithRecomBlock:^(Recom *recom) {
    } requestBlock:^(NSMutableArray *headers) {
        [HttpManager httpNetWorkReachabilityWithCompletion:^(BOOL state) {
            RushView *rushView = headers[1];
            EatView *eatView = headers[2];
            HotChannelView *hotView = headers[3];
            if (state) {
                [HomeItem itemRequestWithCompletion:^(NSArray<HomeItem *> *models) {
                    if (models.count>0) {
                        self.dataArr = [NSMutableArray arrayWithArray:models];
                        [self.tableView reloadData];
                    }
                }];
                [Rush rushRequestWithCompletion:^(Rush *rush){
                    if (rush) {
                        rushView.rush = rush;
                    }else [headers removeObject:rushView];
                    [Eat eatRequestWithCompletion:^(NSArray<Eat *> *eats) {
                        if (eats.count>0) {
                            [eatView eatViewReloadData:eats];
                        }else [headers removeObject:eatView];
                    [HotTopic topicRequestWithCompletion:^(NSArray<HotTopic *> *topics) {
                        if (topics.count>0) {
                            [hotView reloadData:topics];
                        
                        }else [headers removeObject:hotView];
                        [self.tableView reloadData];
                    }];
                    }];
                }];
            }else {
                NSArray *items = [HomeItem lastModels];
                if (items) {
                    self.dataArr = [NSMutableArray arrayWithArray:items];
                }
                Rush *rush = [Rush lastRush];
                if (rush) {
                    rushView.rush = rush;
                }else [headers removeObject:rushView];
                NSArray *arr = [Eat lastEatPlays];
                if (arr.count>0) {
                    [eatView eatViewReloadData:arr];
                }else [headers removeObject:eatView];
                NSArray *hotArr = [HotTopic lastHotTopics];
                if (hotArr.count>0) {
                    [hotView reloadData:hotArr];
                }else [headers removeObject:hotView];
                [self.tableView reloadData];
            }
        }];
    }];
//    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //重新发请求，但判断网络情况有问题，暂时不刷新
//        [self.tableView.mj_header endRefreshing];
//    }];
//    [self.tableView.mj_header beginRefreshing];
}
#pragma mark--tableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.head.headers.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section!=self.head.headers.count-2) {
        return 0;
    }
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.item = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = self.head.headers[section];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    UIView *view = self.head.headers[section];
    return view.height;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kRGBColor(235, 235, 242, 1);
    if (section==self.head.headers.count-2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = kWhiteColor;
        button.frame = CGRectMake(0, 0, kScreenWidth, kCellHeight-5.f);
        [button setTitle:@"查看全部团购" forState:UIControlStateNormal];
        [button setTitleColor:kDefaulsColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(lookAllShops) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section!=self.head.headers.count-2) {
        return 5.f;
    }
    return kCellHeight;
}
#pragma mark--tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark--热门频道区头点击事件
- (void)lookAllShops {
    
}
#pragma mark--viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = kDefaulsColor;
    CityA *city = [CityA currentCity];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(leftBarButtonClick:) withTitle:city.name imageNamed:@"icon_homepage_downArrow" type:UIButtonImageRight];

}
#pragma mark--viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    self.navigationController.navigationBar.barTintColor = kWhiteColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
