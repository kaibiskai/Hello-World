//
//  ShopView.h
//  MeiTuan
//
//  Created by student on 16/5/6.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Shop;
@interface ShopView : UIView
- (void)reloadDataWithArr:(NSArray*)arr;
- (BOOL)isNeedRequest;
- (void)shopViewDidSelectShop:(void(^)(Shop *shop))shop;
- (void)reloadMoreDataHandle:(void(^)(void))handle location:(void(^)(NSString *name))location;
@end
