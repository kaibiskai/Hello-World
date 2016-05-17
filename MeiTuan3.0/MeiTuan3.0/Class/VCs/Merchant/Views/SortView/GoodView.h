//
//  GoodView.h
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodView : UIView
@property (retain,nonatomic) NSArray *dataArr;
- (void)viewDidSelectItemCompletion:(void(^)(NSString*name))completion dismiss:(void(^)(void))dismiss;
@end
