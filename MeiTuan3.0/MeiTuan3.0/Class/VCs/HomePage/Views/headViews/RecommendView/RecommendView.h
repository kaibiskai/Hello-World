//
//  RecommendView.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Recom;
@interface RecommendView : UIView

// init a RecommendView with selectItem block
+ (instancetype)recommendWithClickBlock:(void(^)(Recom*recom))block;

@end



/*
 custom collectionCell for RecommendView
 */
@interface RecommendCell : UIView

@property (retain,nonatomic) Recom *recom;

@end