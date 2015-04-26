//
//  ZBarChars2.h
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsKit.h"
@interface ZChartsBarDrawView : UIView

/**
 *  视图样式
 */
@property(nonatomic, strong) ZChartsStyle *zChartsStyle;


/**
 *  数据
 */
@property(nonatomic, weak) NSMutableArray *barData;


@end
