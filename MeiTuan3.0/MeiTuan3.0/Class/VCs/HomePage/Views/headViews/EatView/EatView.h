//
//  EatView.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Eat;
@interface EatView : UIView
- (void)eatViewReloadData:(NSArray*)dataArr;
@end
@interface EatCell : UIView
@property (retain,nonatomic) Eat *eat;
@end