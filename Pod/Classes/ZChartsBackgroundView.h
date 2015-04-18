//
//  ZChartsBackgroundView.h
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZChartsBackgroundView : UIView

/**
 *  高度比例,计算得出每像素多少值
 */
@property(nonatomic, assign) CGFloat rowCount;

/**
 *  数据里最大值
 */
@property(nonatomic, assign) int maxValue;

/**
 *  绘制层距离的间距
 */
@property(nonatomic, assign) CGPoint chartsViewMargin;

/**
 *  趋势线条颜色
 */
@property(nonatomic, assign) CGColorRef lineColor;

/**
 *  趋势文字颜色
 */
@property(nonatomic, strong) UIColor *drawTextColor;
@end
