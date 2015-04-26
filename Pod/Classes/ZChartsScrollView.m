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
    [super setContentSize:contentSize];
    
    if (contentSize.width < self.frame.size.width) {
        contentSize.width = self.frame.size.width;
    }
    _barChartsView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    _barChartsView.zChartsStyle =_zChartsStyle;
    
    [self setContentOffset:CGPointMake(self.contentSize.width - self.frame.size.width, 0) animated:NO];
    
}

- (NSMutableArray *)barData {
    if (!_barData) {
        
        _barData = [NSMutableArray arrayWithCapacity:0];
    }
    _barChartsView.barData = _barData;
    return _barData;
}

@end
