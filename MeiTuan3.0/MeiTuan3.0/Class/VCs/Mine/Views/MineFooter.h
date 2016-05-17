//
//  MineFooter.h
//  MeiTuan3.0
//
//  Created by student on 16/5/14.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(NSInteger index);
@interface MineFooter : UIView
- (void)foorerButtonDidClickWithCompletion:(Block)completion;
@end
