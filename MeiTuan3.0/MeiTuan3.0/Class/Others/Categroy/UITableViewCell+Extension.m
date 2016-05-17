//
//  UITableViewCell+Extension.m
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "UITableViewCell+Extension.h"
#import "AccountModel.h"
@implementation UITableViewCell (Extension)
- (void)setAccountModel:(AccountModel *)accountModel {
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.textColor =(accountModel.type)?kDefaulsColor:[UIColor lightGrayColor];
    self.textLabel.text =accountModel.title;
    self.detailTextLabel.text = accountModel.subTitle;
    self.accessoryType =(accountModel.type)? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    
    if (accountModel.headPic&&![accountModel.headPic isEqualToString:@""]) {
        self.imageView.image = [UIImage imageNamed:accountModel.headPic];
    }
}
@end
