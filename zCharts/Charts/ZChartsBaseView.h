//
//  ZChartsBaseView.h
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarChartsScrollView.h"
@interface ZChartsBaseView : UIView


@property(nonatomic, strong) ZBarChartsScrollView *barChartsScrollView;

@property(nonatomic, assign) CGFloat scale;

/**
 *  数据
 */
@property(nonatomic, strong) NSMutableArray *legendData;


@end
