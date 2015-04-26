//
//  ZBarChartsScrollView.m
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsScrollView.h"

@implementation ZChartsScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


- (void)setContentSize:(CGSize)contentSize {
    
    
    if (contentSize.width < self.frame.size.width) {
        contentSize.width = self.frame.size.width;
    }
    _barChartsView = [[ZChartsBarDrawView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    _barChartsView.zChartsStyle =_zChartsStyle;
    [self addSubview:_barChartsView];
    _barChartsView.backgroundColor = [UIColor clearColor];
    _barChartsView.barData = _barData;

    [self setContentOffset:CGPointMake(self.contentSize.width - self.frame.size.width, 0) animated:NO];
    
//    contentSize.width += 20 * 3;
    [super setContentSize:contentSize];
}


- (void)setBarData:(NSMutableArray *)barData {
    if (!_barData) {

        _barData = [NSMutableArray arrayWithCapacity:0];
    }
    _barData = barData;
}

@end
