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
        
        _barChartsView = [[ZChartsBarDrawView alloc] initWithFrame:frame];
        _barChartsView.backgroundColor = [UIColor clearColor];
        [self addSubview:_barChartsView];
    }
    return self;
}


- (void)setContentSize:(CGSize)contentSize {
    
    if (contentSize.width < self.frame.size.width) {
        contentSize.width = self.frame.size.width;
    }
    _barChartsView.frame = CGRectMake(_zChartsStyle.padding, 0, contentSize.width, contentSize.height);
    _barChartsView.zChartsStyle =_zChartsStyle;
    
    [super setContentSize:CGSizeMake(contentSize.width + _zChartsStyle.padding*2, contentSize.height)];
}


- (void)setBarData:(NSMutableArray *)barData {
    _barData = barData;
    _barChartsView.barData = _barData;
}


@end
