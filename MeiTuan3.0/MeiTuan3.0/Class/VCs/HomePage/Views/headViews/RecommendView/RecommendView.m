//
//  RecommendView.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "RecommendView.h"
#import "Recom.h"
#import "UIImageView+WebCache.h"
@interface RecommendView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (retain,nonatomic) UICollectionView *colletionView;
@property (retain,nonatomic) NSArray *dataArr;
@property (retain,nonatomic) UIPageControl *page;
@property (copy,nonatomic) void(^block)(Recom*);
@end
@implementation RecommendView
- (instancetype)initWithClickBlock:(void(^)(Recom*recom))block
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, kScreenWidth, 4*kCut+2*kScreenWidth/5);
      self.dataArr = [Recom allRecoms];
        [self createViews];
        [self createPageControl];
        if (block) {
            self.block = block;
        }
    }
    return self;
}
+ (instancetype)recommendWithClickBlock:(void(^)(Recom*recom))block {
    return [[self alloc]initWithClickBlock:block];
}
#pragma mark--createViews
- (void)createViews {
    UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc]init];
    lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    lay.minimumInteritemSpacing = 0;
    lay.minimumLineSpacing = kCut;
    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height-kCut) collectionViewLayout:lay];
    self.colletionView.backgroundColor =kWhiteColor;
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    [self addSubview:self.colletionView];
    self.colletionView.showsHorizontalScrollIndicator = NO;
    self.colletionView.bounces = NO;
    self.colletionView.pagingEnabled = YES;
    [self.colletionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
}
- (void)createPageControl {
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.height-kCut, kScreenWidth, kCut)];
    self.page.numberOfPages = self.dataArr.count/10;
    self.page.pageIndicatorTintColor = kTranslucentColor;
    self.page.currentPageIndicatorTintColor = kDefaulsColor;
    self.page.enabled = NO;
    [self addSubview:self.page];

}
#pragma mark--collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    RecommendCell *reCell = [[RecommendCell alloc]init];
    reCell.recom = self.dataArr[indexPath.row];
    cell.backgroundView = reCell;
    return cell;
}
#pragma mark--collectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/5-kCut, kCut+kScreenWidth/5);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kCut/2, 0, kCut/2);
}
#pragma mark--collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.block (self.dataArr[indexPath.row]);
}
#pragma mark--scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.page.currentPage = scrollView.contentOffset.x/kScreenWidth;
}

@end
@interface RecommendCell ()
@property (retain,nonatomic) UIImageView *imageView;
@property (retain,nonatomic) UILabel *label;
@end
@implementation RecommendCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self drawViews];
    }
    return self;
}
#pragma mark-- drawViews
- (void)drawViews {
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kCut, kCut, kScreenWidth/5-3*kCut, kScreenWidth/5-3*kCut)];
    [self addSubview:self.imageView];
    self.label = [[UILabel alloc]init];
    self.label.center = CGPointMake(self.imageView.center.x, 3*kCut+self.imageView.height);
    self.label.bounds = CGRectMake(0,0,self.imageView.width, 2*kCut);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.label];
}
#pragma mark--cell get data
-(void)setRecom:(Recom *)recom {
    if (_recom !=recom) {
        _recom = recom;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_recom.iconUrl]];
        self.label.text = _recom.name;
        CGFloat width = [_recom.name widthWithFontSize:17];
        if (width>self.label.width) {
            self.label.bounds = CGRectMake(0, 0, width, 2*kCut);
        }
    }
}
@end