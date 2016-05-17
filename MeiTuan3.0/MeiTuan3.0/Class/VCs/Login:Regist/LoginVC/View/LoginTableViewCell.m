//
//  LoginTableViewCell.m
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "LoginTableViewCell.h"
#import "User.h"
@interface LoginTableViewCell ()
@property (copy,nonatomic) void(^block)(User *);
@end
@implementation LoginTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createDeleteButton];
    }
    return self;
}
- (void)createDeleteButton {
    UIButton *button = [UIButton buttonWithTitle:nil imageNamed:@"btn_close" target:self action:@selector(delete)];
    [button setFontSize:0];
    button.x = kScreenWidth-button.width*4;
    button.y = (kCellHeight-button.height)/2;
    [self addSubview:button];
}
- (void)delete {
    self.block(self.user);
}
- (void)setUser:(User *)user {
    if (_user !=user) {
        _user = user;
        self.textLabel.text = _user.account;
    }
}
- (void)deleteItemWithCompletion:(void(^)(User *user))completion {
    if (completion) {
        self.block = completion;
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
