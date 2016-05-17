//
//  NSString+Extension.m
//  MeiTuan
//
//  Created by student on 16/5/4.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#import "NSString+Extension.h"

#define kWidth 260.f*kScalWidth
@implementation NSString (Extension)
- (CGSize)sizeWithFontSize:(CGFloat)size {
    CGSize strSize = [self boundingRectWithSize:CGSizeMake(kWidth, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size;
    return strSize;
}
-(CGFloat)widthWithFontSize:(CGFloat)size {
    CGFloat width = [self sizeWithFontSize:size].width;
    return width;
}
-(CGFloat)heightWithFontSize:(CGFloat)size {
    CGFloat height = [self sizeWithFontSize:size].height;
    return height;
}
+ (NSString*)pathForFileUnderDocuWith:(NSString*)name {
    return  [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",name]];
}
+ (NSString*)editUrl:(NSString*)url {
    if ([url containsString:@"/w.h"]) {
        NSRange range = [url rangeOfString:@"/w.h"];
        url = [url stringByReplacingCharactersInRange:range withString:@""];
    }
    return url;
}
+ (NSString*)pathForResource:(NSString*)name {
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *path = [[NSBundle mainBundle]pathForResource:arr[0] ofType:arr[1]];
    return path;
}
- (BOOL)isChinese {
    int a =[self characterAtIndex:0];
    if (a > 0x4e00 && a < 0x9fff) {
        return YES;
    }
    return NO;
}
@end
