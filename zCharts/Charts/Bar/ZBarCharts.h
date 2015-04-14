//
//  ZBarChars2.h
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBarCharts : UIView

/**
 *  缩放比例
 */
@property(nonatomic, assign) CGFloat scale;

/**
 *  数据
 */
@property(nonatomic, strong) NSMutableArray *barData;


/**
 *  柱状宽度
 */
@property(nonatomic, assign) CGFloat barWidth;

/**
 *  动画时间. 默认0.4s
 */
@property(nonatomic, assign) float duration;


/**
 *  数据最大值
 */
//@property(nonatomic, assign, readonly) CGFloat maxData;

@end
