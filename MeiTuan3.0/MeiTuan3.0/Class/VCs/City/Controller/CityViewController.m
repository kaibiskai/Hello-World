//
//  CityViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/11.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "CityViewController.h"
#import "CityHead.h"
#import "CityView.h"
#import "SearchView.h"
@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSArray *dataArr, *titles;
@property (retain,nonatomic) CityHead *head;
@property (retain,nonatomic) CityView *cityView;
@property (retain,nonatomic) UIView *tableHeader;
@property (retain,nonatomic) SearchView *searchView;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self createTableView];
}
#pragma mark--setUpNav
- (void)setUpNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(leftBarButtonClick) withTitle:@"美团团购" imageNamed:@"btn_backItem_center" type:UIButtonImageLeft];
    [self.navigationItem.leftBarButtonItem setTitleColor:kBlackColor forState:UIControlStateNormal];
}
#pragma mark--createTableView
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.head = [[CityHead alloc]init];
    [self setUpTableHeader];
    [CityA allCitysSortByFirstLetterWithCompletion:^(NSArray<NSArray<CityA*>*>*dataArr, NSArray<NSString *> *titles) {
        self.dataArr = dataArr;
        self.titles = titles;
    }];
    self.tableView.sectionIndexColor = kDefaulsColor;
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, kNavHeight+kCellHeight, kScreenWidth, kScreenHeight-kNavHeight+kCellHeight)];
    [self.view addSubview:self.searchView];
    [self.searchView searchViewDidSelectRowHandle:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark--setUpTableHeader
- (void)setUpTableHeader {
    self.tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2*kCellHeight)];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(2*kCut, 0, kScreenWidth-4*kCut, kCellHeight)];
    searchBar.delegate = self;
    searchBar.placeholder = @"城市/行政区/拼音";
    [self.tableHeader addSubview:searchBar];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kCut, kCellHeight, kScreenWidth/2, kCellHeight)];
    label.font = [UIFont systemFontOfSize:15];
    UIButton *button = [UIButton buttonWithTitle:@"选择县区" imageNamed:@"arrow_down" target:self action:@selector(chooseeArea:)];
    [button setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateSelected];
    button.fontSize = 12;
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.type = UIButtonImageRight;
    button.frame = CGRectMake(kScreenWidth-2*kCut-button.width, kCellHeight, button.width, kCellHeight);
    CityA *city = [CityA currentCity];
    label.text = [NSString stringWithFormat:@"当前：%@",city.name];
    [self.tableHeader addSubview:label];
    [self.tableHeader addSubview:button];
    self.tableView.tableHeaderView = self.tableHeader;
}
#pragma mark--TableHeaderButtonClick
- (void)chooseeArea:(UIButton*)sender {
        sender.selected = !sender.selected;
    CityA *city = [CityA currentCity];
    City *aCity = [City cityWithCityName:city.name];
        if (sender.selected) {
            self.cityView = [[CityView alloc]initWithAreas:aCity.areas];
            [self.cityView cityButtonDidClickWithCompletion:^ {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            self.cityView.y = 2*kCellHeight;
            [self.tableHeader addSubview:self.cityView];
            self.tableHeader.height =2*kCellHeight+self.cityView.height;
        }else{
            [self.cityView removeFromSuperview];
            self.tableHeader.height = 2*kCellHeight;
        }
    self.tableView.tableHeaderView = self.tableHeader;
}
#pragma mark--leftBarButtonClick
- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--tableView.dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.head.headers.count) {
        return 1;
    }
    return [self.dataArr[section-self.head.headers.count]count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.head.headers.count+self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    UIView *oldView = [cell viewWithTag:kCityViewTag];
    [oldView removeFromSuperview];
    if (indexPath.section<self.head.headers.count) {
        CityView *view = self.head.headers[indexPath.section];
        [cell addSubview:view];
        [view cityButtonDidClickWithCompletion:^ {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        cell.textLabel.text = @"";
    }else{
    CityA *city = self.dataArr[indexPath.section-self.head.headers.count][indexPath.row];
        cell.textLabel.text = city.name;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<self.head.headers.count) {
        UIView *view = self.head.headers[indexPath.section];
        return view.height;
    }
    return kCellHeight;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section<self.head.headers.count) {
        return self.head.titles[section];
    }
    return self.titles[section-self.head.headers.count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeight;
}
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.titles;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return self.head.headers.count+index;
}
#pragma mark--tableView.delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section>=self.head.headers.count) {
         CityA *city = self.dataArr[indexPath.section-self.head.headers.count][indexPath.row];
        city.lastest = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark--searchBar.delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchView.hidden = (searchText.length==0)?YES:NO;
    [self.searchView reloadDataWithSearchText:searchText];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
