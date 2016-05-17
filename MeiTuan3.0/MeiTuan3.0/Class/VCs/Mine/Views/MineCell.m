//
//  MineCell.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
-(void)setModel:(Mine *)model {
    if (_model != model) {
        _model = model;
        self.imageView.image = [UIImage imageNamed:_model.imageName];
        self.textLabel.text = _model.title;
        self.detailTextLabel.text = _model.subTitle;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
