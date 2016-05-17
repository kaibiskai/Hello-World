//
//  MiscCell.m
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "MiscCell.h"
@interface MiscCell ()
@property (nonatomic,retain)UISwitch *mySwitch;
@end
@implementation MiscCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        [self createView];
    }
    return self;
}
- (void)createView {
    self.mySwitch = [[UISwitch alloc]init];
    self.mySwitch.x = kScreenWidth-kCut-self.mySwitch.width;
    self.mySwitch.y = (kCellHeight-self.mySwitch.height)/2;
    [self addSubview:self.mySwitch];
}
-(void)setModel:(Misc *)model {
    if (_model != model) {
        _model = model;
        self.textLabel.text = _model.title;
        self.detailTextLabel.text = _model.subTitle;
        self.mySwitch.hidden = !_model.status;
        self.accessoryType = (_model.status)?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
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
