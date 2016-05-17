//
//  MiscViewController.m
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MiscViewController.h"
#import "MiscCell.h"
@interface MiscViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSArray *dataArr;
@end

@implementation MiscViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多";
    [self createTableView];
}
#pragma mark--createTableView
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabHeight, 0);
    self.dataArr = [Misc allData];
}
#pragma mark--tableView.dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiscCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[MiscCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    cell.model = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCut/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
#pragma mark--tableView.delegate
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
