//
//  HomeTableViewCell.h
//  MeiGrounp
//
//  Created by student on 16/4/28.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeItem;
#define kHeight 145.f*kScalWidth
@interface HomeTableViewCell : UITableViewCell
@property (nonatomic,retain) HomeItem *item;
@end
