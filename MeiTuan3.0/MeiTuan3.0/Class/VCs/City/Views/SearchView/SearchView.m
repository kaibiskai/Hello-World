//
//  SearchView.m
//  MeiGrounp
//
//  Created by student on 16/4/26.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "SearchView.h"
@interface SearchView ()<UITableViewDataSource,UITableViewDelegate>
@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSArray *dataArr;
@property (copy,nonatomic)void(^block)(void);
@end
@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr = @[].mutableCopy;
        [self drawViews];
        self.hidden = YES;
    }
    return self;
}
+ (instancetype)searchViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}
- (void)drawViews {
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    CityA *city = self.dataArr[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityA *city = self.dataArr[indexPath.row];
    city.lastest = YES;
    self.block();
}
- (void)searchViewDidSelectRowHandle:(void(^)(void))handle {
    if (handle) {
        self.block = handle;
    }
}
-(void)reloadDataWithSearchText:(NSString*)searchText{
    self.dataArr =[CityA selectCitysWithSearchText:searchText];
    [self.tableView reloadData];
}
@end
