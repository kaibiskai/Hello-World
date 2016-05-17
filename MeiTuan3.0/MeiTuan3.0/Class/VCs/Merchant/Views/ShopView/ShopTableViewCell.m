//
//  ShopTableViewCell.m
//  MeiGrounp
//
//  Created by student on 16/4/24.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Shop.h"
@interface ShopTableViewCell ()
@property (retain,nonatomic) UIImageView *pic;
@property (retain,nonatomic) UILabel *titleLabel;
@property (retain,nonatomic) UIView *star;
@property (retain,nonatomic) UILabel *evaluationLabel;
@property (retain,nonatomic) UILabel *priceLabel;
@property (retain,nonatomic) UILabel *catLabel;
@property (retain,nonatomic) UILabel *addLabel;
@property (retain,nonatomic) UILabel *disLabel;
@end
@implementation ShopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}
- (void)createViews {
    self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(kCut, kCut, kHeight-2*kCut, kHeight-2*kCut)];
    [self addSubview:self.pic];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kHeight, 2*kCut, 0, kHeight/4)];
    [self addSubview:self.titleLabel];
    self.star = [[UIView alloc]initWithFrame:CGRectMake(kHeight, self.titleLabel.height+self.titleLabel.y+kCut, 10, kHeight/6)];
    [self addSubview:self.star];
    self.evaluationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.star.y, 0, self.star.height)];
    self.evaluationLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.evaluationLabel];
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.star.y, 0, self.star.height)];
    self.priceLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.priceLabel];
    self.catLabel = [[UILabel alloc]initWithFrame:CGRectMake(kHeight, kHeight-2*kCut-kHeight/6, 0, kHeight/6)];
    self.catLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.catLabel];
    self.addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.catLabel.y, 0, self.catLabel.height)];
    self.addLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.addLabel];
}
-(void)setShop:(Shop *)shop {
    if (_shop!=shop) {
        _shop = shop;
        [self.pic sd_setImageWithURL:[NSURL URLWithString:_shop.frontImg]placeholderImage:[UIImage imageNamed:@"icon_empty_coupon"]];
        [self setLabel:self.titleLabel withText:_shop.name fontSize:17];
        NSInteger count = [self getStarNumWithNum:_shop.avgScore];
        self.star.width = self.star.height*count;
        for (int i =0; i<count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.star.height*i, 0, self.star.height, self.star.height)];
            imageView.image = [UIImage imageNamed:@"icon_feedCell_star_full"];
            [self.star addSubview:imageView];
        }
        self.evaluationLabel.x = self.star.x+self.star.width+kCut;
        [self setLabel:self.evaluationLabel withText:[NSString stringWithFormat:@"%ld评价",_shop.markNumbers]fontSize:14];
        if (_shop.avgPrice>0) {
            [self setLabel:self.priceLabel withText:[NSString stringWithFormat:@"人均￥%ld",_shop.avgPrice]fontSize:14];
            self.priceLabel.x = kScreenWidth-kCut-self.priceLabel.width;
        }
        [self setLabel:self.catLabel withText:_shop.cateName fontSize:14];
        self.addLabel.x = self.catLabel.x+self.catLabel.width+kCut;
        [self setLabel:self.addLabel withText:_shop.areaName fontSize:14];
    }
}
- (NSInteger)getStarNumWithNum:(CGFloat)num {
    NSInteger count = num;
    if (count<num) {
        count++;
    }
    return count;
}
-(void)setLabel:(UILabel*)label withText:(NSString*)text fontSize:(CGFloat)size{
    label.text = text;
    CGFloat width = [text widthWithFontSize:size];
    label.width = width;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
