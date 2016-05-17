//
//  SortView.h
//  MeiTuan3.0
//
//  Created by student on 16/5/15.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cate;
@interface SortView : UIView
- (void)SortViewDidSelectItemCompletion:(void(^)(NSString*name))completion dismiss:(void(^)(void))dismiss;
@end
