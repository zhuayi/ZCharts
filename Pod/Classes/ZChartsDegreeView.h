//
//  ZChartsBackgroundView.h
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsKit.h"
@interface ZChartsDegreeView : UIView


/**
 *  视图样式
 */
@property(nonatomic, weak) ZChartsStyle *zChartsStyle;


/**
 *  数据里最大值
 */
@property(nonatomic, assign) int maxValue;


@end
