//
//  ZBarChartsScrollView.m
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsScrollView.h"

@implementation ZChartsScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_barChartsView) {
            _barChartsView = [[ZChartsBarDrawView alloc] init];
        }
        
        [self addSubview:_barChartsView];
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        // 默认柱状10宽
        _barWidth = 20.0;
    }
    return self;
}



- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    
    if (contentSize.width < self.frame.size.width) {
        contentSize.width = self.frame.size.width;
    }
    _barChartsView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    _barChartsView.backgroundColor = [UIColor clearColor];
    
    // _barChartsView的 data 数据必须设置 frame 之后才能赋值,否则取不到高度无法计算缩放比例
    _barChartsView.barData = _barData;
    _barChartsView.barWidth = _barWidth;
    
    self.contentOffset = CGPointMake(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self setContentOffset:CGPointMake(self.contentSize.width - self.frame.size.width - 2, 0) animated:YES];
    });


}

- (void)setBarWidth:(CGFloat)barWidth {
    _barWidth = barWidth;
    _barChartsView.barWidth = barWidth;
}

- (void)setBarData:(NSMutableArray *)barData {
    if (!_barData) {

        _barData = [NSMutableArray arrayWithCapacity:0];
    }
    _barData = barData;
}

@end
