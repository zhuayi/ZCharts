//
//  ZBarChartsScrollView.h
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsBarDrawView.h"

@interface ZChartsScrollView : UIScrollView

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
