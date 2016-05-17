//
//  GuideView.h
//  MeiTuan3.0
//
//  Created by student on 16/5/10.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView
- (instancetype)initWithImages:(NSArray<NSString*>*)images;
//show on window and click guideButton block
- (void)showSelfWithCompletion:(void(^)(void))completion;
@end
