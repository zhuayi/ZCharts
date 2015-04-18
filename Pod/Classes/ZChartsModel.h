//
//  ZChartsModel.h
//  zCharts
//
//  Created by zhuayi on 15/4/15.
//  Copyright (c) 2015年 renxin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZChartsModel : NSObject

/**
 *  值
 */
@property(nonatomic, assign) CGFloat value;

/**
 *  分类
 */
@property(nonatomic, strong) NSString *category;

/**
 *  坐标
 */
@property(nonatomic, assign) CGPoint point;

/**
 *  是否选中高亮
 */
@property(nonatomic, assign) BOOL isSelect;
@end
