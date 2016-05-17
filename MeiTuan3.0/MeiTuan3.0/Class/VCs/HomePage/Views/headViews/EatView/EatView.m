//
//  EatView.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "EatView.h"
#import "Eat.h"
#import "UIImageView+WebCache.h"
@interface EatView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (retain,nonatomic) NSMutableArray*dataArr;
@property (retain,nonatomic) UICollectionView *collectionView;
@end
@implementation EatView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray array];
        self.height = (kCellHeight+2*kCut)*4;
        self.width = kScreenWidth;
        [self createCateView];
    }
    return self;
}
- (void)createCateView {
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:lay];
    self.collectionView.backgroundColor = kRGBColor(235, 235, 242, 1);
    self.collectionView.delegate = self;
    self.collectionView.dataSource =self;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
     ;
    cell.backgroundView = self.dataArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    EatCell *rushCell =self.dataArr[indexPath.row];
    return CGSizeMake(rushCell.width, rushCell.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EatCell *cell = self.dataArr[indexPath.row];
    NSLog(@"%@",cell.eat.maintitle);
}
- (void)eatViewReloadData:(NSArray*)dataArr {
    [self.dataArr removeAllObjects];
    for (int i =0; i<dataArr.count; i++) {
        EatCell *cell = [[EatCell alloc]init];
        cell.eat = dataArr[i];
        [self.dataArr addObject:cell];
    }
    [self.collectionView reloadData];
}
@end
@interface EatCell ()
@property (retain,nonatomic) UIImageView *imageView;
@property (retain,nonatomic) UILabel *label;
@property (retain,nonatomic) UILabel *subLabel;
@end
@implementation EatCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = kCellHeight+2*kCut;
        self.width = kScreenWidth/2-1;
        [self drawViews];
    }
    return self;
}
- (void)drawViews {
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(kCut, kCut, 0, kCellHeight/2)];
    self.label.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.label];
    self.subLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCut, 2*kCut+self.label.height, 0, 2*kCut)];
    self.subLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.subLabel];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-kCut-kCellHeight, kCut, kCellHeight, kCellHeight)];
    [self addSubview:self.imageView];
}
-(void)setEat:(Eat *)eat {
    if (_eat!=eat) {
        _eat = eat;
        self.label.textColor = kRGBColor(arc4random()%256, arc4random()%256, arc4random()%256, 1);
        self.label.text = _eat.maintitle;
        self.label.width = [_eat.maintitle widthWithFontSize:17];
        self.subLabel.text = _eat.deputytitle;
        self.subLabel.width = [_eat.deputytitle widthWithFontSize:14];
        if (_eat.position ==1) {
            self.width = kScreenWidth;
            self.imageView.x = self.width/2;
            self.imageView.width = self.width/2-kCut;
        }
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_eat.imageurl]];
    }
}
@end