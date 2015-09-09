//
//  ZCharsStyle.h
//  IOSLib
//
//  Created by zhuayi on 9/9/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCharsKit.h"

@interface ZCharsStyle : NSObject

/**
 *  单例方法
 *
 *  @return
 */
+ (ZCharsStyle *)sharedManager;

+ (void)dellocInstance;

@property (nonatomic, assign) CGFloat viewHeight;

/**
 *  数值对应的 view 比例
 */
@property (nonatomic, assign) CGFloat ratio;

/**
 *  行数
 */
@property (nonatomic, assign) NSInteger rowCount;

/**
 *  每列宽度
 */
@property (nonatomic, assign) CGFloat columnWidth;

/**
 *  最大值和最小值区间
 */
@property (nonatomic, assign) ZChasValue valueSection;

/**
 * 间距
 */
@property (nonatomic, assign) UIEdgeInsets rightInsets;

/**
  *  底部偏移量
  */
@property (nonatomic, assign) CGFloat bottomSpace;

/**
 *  绘制高度
 */
@property (nonatomic, assign) CGFloat drawHeight;

/**
 *  数据数
 */
@property (nonatomic, assign) NSInteger dataCount;

@end
