//
//  ZBarChartsScrollView.m
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZBarChartsScrollView.h"
@implementation ZBarChartsScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_barChartsView)
        {
            _barChartsView = [[ZBarCharts alloc] init];
        }
        [self addSubview:_barChartsView];
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        
        // 默认柱状20宽
        _barWidth = 20;
    }
    return self;
}

- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    
    if (contentSize.width < self.frame.size.width)
    {
        contentSize.width = self.frame.size.width;
    }
    _barChartsView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    
    // _barChartsView的 data 数据必须设置 frame 之后才能赋值,否则取不到高度无法计算缩放比例
    _barChartsView.barData = _barData;
    _barChartsView.barWidth = _barWidth;
}

- (void)setBarWidth:(CGFloat)barWidth
{
    _barWidth = barWidth;
    _barChartsView.barWidth = barWidth;
}

- (void)setBarData:(NSMutableArray *)barData
{
    if (!_barData) {

        _barData = [NSMutableArray arrayWithCapacity:0];
    }
    _barData = barData;
    
    if (_barWidth * _barData.count < self.frame.size.width)
    {
        _barWidth = self.frame.size.width / _barData.count - 5;
        NSLog(@"柱子太小, 放大点");
    }
    
    self.contentSize = CGSizeMake(barData.count * (_barWidth + 5), self.frame.size.height);
}
@end
