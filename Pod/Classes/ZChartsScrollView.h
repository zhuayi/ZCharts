//
//  ZBarChartsScrollView.h
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsKit.h"

@class ZChartsBarDrawView;

@interface ZChartsScrollView : UIScrollView

/**
 *  视图样式
 */
@property(nonatomic, weak) ZChartsStyle *zChartsStyle;

/**
 *  柱状图 view
 */
@property(nonatomic, strong) ZChartsBarDrawView *barChartsView;

/**
 *  数据
 */
@property(nonatomic, strong) NSMutableArray *barData;

/**
 *  柱状宽度
 */
@property(nonatomic, assign) CGFloat barWidth;


@end
