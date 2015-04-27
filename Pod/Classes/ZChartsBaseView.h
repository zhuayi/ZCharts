//
//  ZChartsBaseView.h
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZChartsKit.h"
@class ZChartsStyle;
@class ZChartsScrollView;
@class ZChartsDegreeView;
@class ZChartsModel;
@protocol ZChartsBaseViewDelegate <NSObject>

- (void)scrollViewDidScroll:(CGFloat)contentOffsetScale  zChartsModel:(ZChartsModel *)zChartsModel;

@end


@interface ZChartsBaseView : UIView<UIScrollViewDelegate>

@property(nonatomic, weak) id<ZChartsBaseViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame zChartsStyle:(ZChartsStyle *)zChartsStyle;

/**
 *  视图样式
 */
@property(nonatomic, strong) ZChartsStyle *zChartsStyle;


/**
 *  柱状图Scrollview
 */
@property(nonatomic, strong) ZChartsScrollView *zChartsScrollView;


@property(nonatomic, strong) ZChartsDegreeView *zchartsDegreeView;


/**
 *  数据
 */
@property(nonatomic, strong) NSMutableArray *legendData;


/**
 *  滚动到第几个柱子
 *
 *  @param barIndex 柱子索引
 */
- (void)scrollToItemAtBarIndex:(NSInteger)barIndex;


@end
