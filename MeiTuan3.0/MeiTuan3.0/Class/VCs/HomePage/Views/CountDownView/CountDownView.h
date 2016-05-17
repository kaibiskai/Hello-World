//
//  CountDownView.h
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)();
@interface CountDownView : UIView
// 时间戳
@property (nonatomic,assign)NSInteger timeTravel;
@end
