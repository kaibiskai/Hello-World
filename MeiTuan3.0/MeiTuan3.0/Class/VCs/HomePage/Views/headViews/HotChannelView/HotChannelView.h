//
//  HotChannelView.h
//  MeiTuan
//
//  Created by student on 16/5/5.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotTopic;
@interface HotChannelView : UIView
-(void)reloadData:(NSArray*)dataArr;
@end
@interface HotChannelCell : UIView
@property (retain,nonatomic) HotTopic *topic;
@end