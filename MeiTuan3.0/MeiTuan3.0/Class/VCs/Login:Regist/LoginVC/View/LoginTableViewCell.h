//
//  LoginTableViewCell.h
//  MeiTuan
//
//  Created by student on 16/5/8.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@interface LoginTableViewCell : UITableViewCell
@property (nonatomic,retain) User *user;
- (void)deleteItemWithCompletion:(void(^)(User *user))completion;
@end
