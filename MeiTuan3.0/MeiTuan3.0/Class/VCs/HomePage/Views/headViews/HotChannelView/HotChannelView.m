//
//  HotChannelView.m
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HotChannelView.h"
#import "HotTopic.h"
#import "UIImageView+WebCache.h"
@interface HotChannelView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (retain,nonatomic) UICollectionView *collectionView;
@property (retain,nonatomic) NSMutableArray *dataArr;
@end
@implementation HotChannelView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height =3* kCellHeight+3+14*kCut;
        self.width = kScreenWidth;
        self.dataArr = [NSMutableArray array];
        [self createCateView];
    }
    return self;
}
-(void)reloadData:(NSArray*)dataArr {
    for (int i = 0; i<dataArr.count; i++) {
        HotChannelCell *cell = [[HotChannelCell alloc]init];
        cell.topic = dataArr[i];
        [self.dataArr addObject:cell];
    }
    [self.collectionView reloadData];
}
- (void)createCateView {
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:lay];
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource =self;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kRGBColor(235, 235, 242, 1);
    cell.backgroundView = self.dataArr[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.imageView.image = [UIImage imageNamed:@"icon_travel_hot_poi"];
    cell.width = kScreenWidth;
    cell.textLabel.text = @"热门频道";
    cell.detailTextLabel.text = @"查看全部";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [view addSubview:cell];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = cell.bounds;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
- (void)buttonClick:(UIButton*)sender {
    //进入热门频道
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, kCellHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view =self.dataArr[indexPath.row];
    return CGSizeMake(view.width, view.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,1,2,1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    EatCell *cell = self.dataArr[indexPath.row];
//    NSLog(@"%@",cell.eat.maintitle);
}
@end
@interface HotChannelCell ()
@property (retain,nonatomic) UILabel *mainLabel;
@property (retain,nonatomic) UILabel *subLabel;
@property (retain,nonatomic) UIImageView *imageView;
@end
@implementation HotChannelCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.width = (kScreenWidth-5)/4;
        self.height = 7*kCut+kCellHeight;
        [self createViews];
    }
    return self;
}
- (void)createViews {
    self.mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kCut, self.width, 2*kCut)];
    self.mainLabel.font = [UIFont systemFontOfSize:15];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.mainLabel];
    self.subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 4*kCut, self.width, kCut)];
    self.subLabel.font = [UIFont systemFontOfSize:12];
    self.subLabel.textAlignment = NSTextAlignmentCenter;
    self.subLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.subLabel];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-kCellHeight)/2, 6*kCut, kCellHeight, kCellHeight)];
    [self addSubview:self.imageView];
}
-(void)setTopic:(HotTopic *)topic {
    if (_topic !=topic) {
        _topic = topic;
        self.mainLabel.text = _topic.mainTitle;
        self.subLabel.text = _topic.deputyTitle;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.entranceImgUrl]];
    }
}
@end