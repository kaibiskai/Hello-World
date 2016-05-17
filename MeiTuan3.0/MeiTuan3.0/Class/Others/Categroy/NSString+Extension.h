//
//  NSString+Extension.h
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
//get size by font
- (CGSize)sizeWithFontSize:(CGFloat)size;
-(CGFloat)widthWithFontSize:(CGFloat)size;
-(CGFloat)heightWithFontSize:(CGFloat)size;


//get path of file which under Documents
+ (NSString*)pathForFileUnderDocuWith:(NSString*)name;
//get path of file in resource
+ (NSString*)pathForResource:(NSString*)name;

- (BOOL)isChinese;

//
+ (NSString*)editUrl:(NSString*)url;


@end
