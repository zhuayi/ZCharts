//
//  ZChartsBaseView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBaseView.h"
#import "ZChartsBackgroundView.h"

/**
 *  比较两个参数数值大小
 *
 *  @param obj1 参数1
 *  @param obj2 参数2
 *
 *  @return NSComparator 对比结果
 */
NSComparator cmptr = ^(id obj1, id obj2){
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

/**
 *  柱状视图坐间距,用来画线
 */
const static int barChartsViewMarginLeft = 15;

@implementation ZChartsBaseView
{
    ZBarChartsScrollView *_barChartsScrollView;
    
    ZChartsBackgroundView *zchartsBackgroundView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _barChartsScrollView = [[ZBarChartsScrollView alloc] initWithFrame:CGRectMake(barChartsViewMarginLeft,
                                                                                      barChartsViewMarginLeft / 2,
                                                                                      self.frame.size.width - barChartsViewMarginLeft,
                                                                                      self.frame.size.height - barChartsViewMarginLeft
                                                                                      )];
        
        
        [self addSubview:_barChartsScrollView];
        
        zchartsBackgroundView = [[ZChartsBackgroundView alloc] initWithFrame:CGRectMake(
                                                                                       0,
                                                                                       0,
                                                                                       self.frame.size.width,
                                                                                       self.frame.size.height
                                                                                       )];
        zchartsBackgroundView.userInteractionEnabled = NO;
        zchartsBackgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:zchartsBackgroundView];
    }
    return self;
}

- (void)setLegendData:(NSMutableArray *)legendData {
    if (!_legendData) {
        
        _legendData = [NSMutableArray arrayWithCapacity:0];
    }
    _legendData = legendData;
    
    _barChartsScrollView.barData = legendData;
    
    // 获取最大值
     CGFloat maxData = [[[legendData sortedArrayUsingComparator:cmptr] lastObject] floatValue];
    _scale = (self.frame.size.height - barChartsViewMarginLeft / 2) * 0.9 / maxData;
    _barChartsScrollView.barChartsView.scale = _scale;

    zchartsBackgroundView.heightScale = maxData * _barChartsScrollView.barChartsView.scale / maxData;
    zchartsBackgroundView.maxValue = maxData;
    zchartsBackgroundView.scale = _barChartsScrollView.barChartsView.scale;
    zchartsBackgroundView.marginLeft = barChartsViewMarginLeft;
    
}



@end
