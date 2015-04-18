//
//  ZChartsBaseView.h
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsScrollView.h"
#import "ZChartsBackgroundView.h"
#import "ZChartsModel.h"

@interface ZChartsBaseView : UIView<UIScrollViewDelegate>

/**
 *  柱状图Scrollview
 */
@property(nonatomic, strong) ZChartsScrollView *zChartsScrollView;


@property(nonatomic, strong) ZChartsBackgroundView *zchartsBackgroundView;

/**
 *  绘制层距离的间距
 */
@property(nonatomic, assign) CGPoint chartsViewMargin;

/**
 *  缩放比例
 */
@property(nonatomic, assign) CGFloat scale;

/**
 *  数据
 */
@property(nonatomic, strong) NSMutableArray *legendData;


/**
 *  趋势线条颜色
 */
@property(nonatomic, assign) CGColorRef lineColor;

/**
 *  趋势文字颜色
 */
@property(nonatomic, strong) UIColor *drawTextColor;


@end
