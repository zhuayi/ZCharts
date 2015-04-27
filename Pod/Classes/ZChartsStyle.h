//
//  ZChartsStyle.h
//  ZCharts
//
//  Created by zhuayi on 15/4/25.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZChartsStyle : NSObject

/**
 *  刻度 view 的宽度
 */
@property(nonatomic, assign) CGFloat degreeViewWidth;

/**
 *  刻度 view 的右间距
 */
@property(nonatomic, assign) CGFloat degreeViewMarginRight;

/**
 *  刻度 View, 字体样式
 */
@property(nonatomic, strong) NSDictionary *degreeViewFontStyle;

/**
 *  刻度最小值
 */
@property(nonatomic, assign) CGFloat degreeminValue;

/**
 *
 */
@property(nonatomic, assign) CGFloat padding;

/**
 * 显示几行刻度
 */
@property(nonatomic, assign) NSInteger rowCount;

/**
 *  柱状图宽度
 */
@property(nonatomic, assign) CGFloat barWidth;

/**
 *  每个柱子间距
 */
@property(nonatomic, assign) CGFloat minimumRowSpacing;

/**
 *  动画时间. 默认0.4s
 */
@property(nonatomic, assign) float duration;


@end

