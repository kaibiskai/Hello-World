//
//  Header.h
//  MeiTuan3.0
//
//  Created by student on 16/5/9.
//  Copyright © 2016年 Klaus. All rights reserved.
//

#ifndef Header_h
#define Header_h
/*
 debug状态下的NSLog
 */
#ifdef DEBUG
#define KSLog(...) NSLog(__VA_ARGS__)
#else
#define KSLog(...)
#endif
/*
 屏幕宽高
 */
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenHeight   kScreenBounds.size.height
#define kScreenWidth   kScreenBounds.size.width
#define kNavHeight     64.0f
#define kTabHeight     49.0f
#define kCellHeight       44.0f
#define kCut                  10.0f*kScalWidth
#define kLine                  1.0f
#define kScalWidth       kScreenWidth/414.0
#define kScalHeight       kScreenHeight/736.0
/*
 颜色
 */
#define kRGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kDefaulsColor  kRGBColor(58, 167, 151, 1)
#define kTranslucentColor   kRGBColor(35, 35, 35, 0.5)
#define kWhiteColor  kRGBColor(255, 255, 255, 1)
#define kBlackColor  kRGBColor(0, 0, 0, 1)
#define kBGColor kRGBColor(235, 235, 242, 1)
/*
 cell标识符
 */
#define kCellIdentifier @"cell"

/*
 version 版本号
 */
#define kVERSION @"MeiTuan3.0"
#endif /* Header_h */
