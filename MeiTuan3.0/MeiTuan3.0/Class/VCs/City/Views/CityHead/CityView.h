//
//  CityView.h
//  MeiTuan3.0
//
//  Created by student on 16/5/13.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickBlock)(void);
#define kCityViewTag 100
@interface CityView : UIView
- (instancetype)initWithAreas:(NSArray*)areas;
- (void)cityButtonDidClickWithCompletion:(clickBlock)completion;
@end
