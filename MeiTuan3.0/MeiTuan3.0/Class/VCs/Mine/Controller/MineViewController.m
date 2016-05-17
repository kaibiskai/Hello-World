//
//  MineViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "MineFooter.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSArray *dataArr;
@property (retain,nonatomic) MineFooter *footer;
@property (assign,nonatomic) BOOL login;
@property (retain,nonatomic) UIButton *accountButton;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpNav];
    [self createTableView];
}
#pragma mark--setUpNav 
- (void)setUpNav {
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem itemsAddTarget:self action:@selector(rightBarButtonClick:) withTitles:nil imageNamed:@[@"icon_homepage_message",@"icon_mine_account_setting_white"]];
}
#pragma mark--rightBarButtonClick
- (void)rightBarButtonClick:(UIButton*)sender {
    //0.在未登陆状态下模态至登陆界面；在登陆状态下push至消息界面
    //1.在未登陆状态下模态至登陆界面；在登陆状态下push至我的账户界面
    if (!self.login) {
        [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
    }else{
        if (sender.tag==1) {
            //进入我的账户界面
        }else{
            //进入消息界面
        }
        
    }
}
#pragma mark--createTableView
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabHeight, 0);
    self.dataArr = [Mine allData];
    [self setUpTableHeader];
    self.footer = [[MineFooter alloc]init];
    [self.footer foorerButtonDidClickWithCompletion:^(NSInteger index) {
        //0-3.未登录状态下模态至登录界面；登录状态下进入相对界面
        if (!self.login) {
            [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
        }
    }];
}
#pragma mark--setUpTableHeader 
- (void)setUpTableHeader {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kDefaulsColor;
    self.accountButton = [UIButton buttonWithTitle:@"点击登录" imageNamed:@"icon_mine_default_portrait" target:self action:@selector(accontButton:)];
    self.accountButton.frame = CGRectMake(2*kCut,kCut+kNavHeight, 0, 0);
    self.accountButton.fontSize = 15;
    [view addSubview:self.accountButton];
    NSArray *arr = @[@"美团券",@"评价",@"收藏"];
    for (int i =0; i<arr.count; i++) {
        UIButton *bottomButton = [UIButton buttonWithTitle:arr[i] imageNamed:nil target:self action:@selector(headBottomButtonClick:)];
        bottomButton.frame = CGRectMake(kScreenWidth/3*i, self.accountButton.y+self.accountButton.height+kCut, kScreenWidth/3, kCellHeight);
        bottomButton.tag = i;
        bottomButton.fontSize = 15;
        [bottomButton setBackgroundImage:[UIImage imageNamed:@"btn_calendar_new_middle"] forState:UIControlStateNormal];
        [view addSubview:bottomButton];
    }
    view.bounds = CGRectMake(0, 0, kScreenWidth, kNavHeight+self.accountButton.height+2*kCut+kCellHeight);
    self.tableView.tableHeaderView = view;
}
#pragma mark--tableHeadButtonClick
- (void)accontButton:(UIButton*)sender {
    if (!self.login) {
        [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
    }else {
        //登录状态下进入账号成长界面
    }
}
- (void)headBottomButtonClick:(UIButton*)sender {
    //0-1. 未登录状态下模态至登录界面；登录状态进入相对界面
    if (sender.tag<2) {
        if (!self.login) {
            [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
        }
    }
    //2.进入收藏界面
}
#pragma mark--tableView.dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    cell.model = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCut/2;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return self.footer;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return self.footer.height;
    }
    return 0.01;
}
#pragma mark--tableView.delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine *mine = self.dataArr[indexPath.section][indexPath.row];
    if (mine.needLogin) {
        if (!self.login) {
            [OtherTool otherToolpresentLoginVCFromCurrentVC:self];
        }else {
            //push至相对界面
//            Class class = NSClassFromString(mine.login);
//            [self.navigationController pushViewController:[class new] animated:YES];
        }
    }else{
        //不需要登录的传一个url过去，加载webView
//        self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = kDefaulsColor;
    User *user = [User currentUser];
    if (user) {
        self.login = YES;
        [self.accountButton setTitle:user.account forState:UIControlStateNormal];
        self.accountButton.fontSize = 15;
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
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
