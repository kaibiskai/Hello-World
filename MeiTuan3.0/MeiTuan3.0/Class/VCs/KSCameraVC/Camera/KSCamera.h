//
//  KSCamera.h
//  MeiTuan3.0
//
//  Created by student on 16/5/12.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#define K_QR_SIDE 200.f
@interface KSCamera : UIView
- (void)cameraScanWithCompletion:(void(^)(NSString*))completion;
@end
