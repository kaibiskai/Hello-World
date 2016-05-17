//
//  UserViewController.m
//  MeiTuan
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"
#import "AccountModel.h"
@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataArr;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kDefaulsColor;
    [self setUpNav];
    [self createTableView];
}
- (void)setUpNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(leftBarButtonCilck) withTitle:@"我的账号" imageNamed:@"btn_backItem_center" type:UIButtonImageNormal];
    [self.navigationItem.leftBarButtonItem setTitleColor:kBlackColor forState:UIControlStateNormal];
}
- (void)createTableView {
    self.dataArr = [AccountModel modelReadPlist:@"account.plist"];
    self.tableView = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        
    }
//    cell.accountModel = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 0.01f;
    }
    return kCellHeight+2*kCut;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==0) {
        return nil;
    }
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kRGBColor(235, 235, 242, 1);
//    UIButton *button = [UIButton buttonWithTitle:@"退出账户" imageNamed:nil target:self action:@selector(exitCurrentAccount) frame:CGRectMake(kCut, kCut, kScreenWidth-2*kCut, kCellHeight)];
//    button.backgroundColor = [UIColor redColor];
//    [view addSubview:button];
    return view;
}
- (void)exitCurrentAccount {
    [User closeCurrentUserWithCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)leftBarButtonCilck {
    [self.navigationController popViewControllerAnimated:YES];
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
