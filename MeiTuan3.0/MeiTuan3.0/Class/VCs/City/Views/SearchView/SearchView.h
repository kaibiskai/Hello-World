//
//  SearchView.h
//  MeiGrounp
//
//  Created by student on 16/4/26.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView
+ (instancetype)searchViewWithFrame:(CGRect)frame;
-(void)reloadDataWithSearchText:(NSString*)searchText;
- (void)searchViewDidSelectRowHandle:(void(^)(void))handle;
@end
