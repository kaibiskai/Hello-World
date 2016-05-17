//
//  HomeTableViewCell.m
//  MeiGrounp
//
//  Created by student on 16/4/28.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeItem.h"
#import "UIImageView+WebCache.h"

#define kBig 45.f*kScalWidth
#define kNormal 30.f*kScalWidth
#define kSmall  20.f*kScalWidth
@interface HomeTableViewCell ()
@property (nonatomic,retain) UIImageView *pic;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *disLabel;
@property (nonatomic,retain) UILabel *detailLabel;
@property (nonatomic,retain) UILabel *priceLabel;
@property (nonatomic,retain) UILabel *saleLabel;
@property (nonatomic,retain) UILabel *tagLabel;
@end
@implementation HomeTableViewCell
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
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kHeight, kCut, 0, kNormal)];
    [self addSubview:self.nameLabel];
    self.disLabel = [[UILabel alloc]init];
    self.disLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.disLabel];
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(kHeight, self.nameLabel.y+self.nameLabel.height, 0, kBig)];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.detailLabel];
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kHeight, kHeight-kCut-kNormal, 0, kNormal)];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.priceLabel];
    self.saleLabel = [[UILabel alloc]init];
    self.saleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.saleLabel];
    self.tagLabel = [[UILabel alloc]init];
    self.tagLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.tagLabel];
}
-(void)setItem:(HomeItem *)item {
    if (_item!=item) {
        _item = item;
        [self.pic sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl]placeholderImage:[UIImage imageNamed:@"icon_empty_coupon"]];
        self.nameLabel.text = _item.title;
        self.nameLabel.width = [_item.title widthWithFontSize:20];
        self.disLabel.text = _item.topRightInfo;
        CGFloat dis = [_item.topRightInfo widthWithFontSize:15];
        self.disLabel.frame = CGRectMake(kScreenWidth-kCut-dis,kCut , dis, kSmall);
        self.detailLabel.text = _item.subTitle;
        self.detailLabel.width = [_item.subTitle widthWithFontSize:24];
        if (self.nameLabel.width+self.nameLabel.x>self.disLabel.x) {
            self.nameLabel.width = self.disLabel.x-kCut-self.nameLabel.x;
        }
        self.priceLabel.text =[NSString stringWithFormat:@"%@%@",_item.mainMessage, _item.mainMessage2];
        self.priceLabel.width = [self.priceLabel.text widthWithFontSize:20];
        self.saleLabel.text = _item.bottomRightInfo;
        self.saleLabel.width = [_item.bottomRightInfo widthWithFontSize:13];
        self.saleLabel.x = kScreenWidth-self.saleLabel.width;
        self.saleLabel.y = kHeight-kCut-kSmall;
        self.saleLabel.height = kSmall;
        self.tagLabel.text = _item.subTag;
        self.tagLabel.frame = CGRectMake(self.priceLabel.x+self.priceLabel.width, self.saleLabel.y, [_item.subTag widthWithFontSize:13], kSmall);
        self.tagLabel.textColor = [UIColor orangeColor];
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
