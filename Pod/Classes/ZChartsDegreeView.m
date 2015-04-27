//
//  ZChartsBackgroundView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsDegreeView.h"
#import "UIView+ZQuartz.h"
@implementation ZChartsDegreeView {
    CGContextRef _context;
}


/**
 *  绘制层
 *
 *  @param rect  view尺寸
 */
- (void)drawRect:(CGRect)rect {
    _context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < _zChartsStyle.rowCount; i++) {
        
        int value = _maxValue/(_zChartsStyle.rowCount - 1) * i;
        
        NSString *text = [NSString stringWithFormat:@"%d", value];
        CGSize size = [text sizeWithAttributes:_zChartsStyle.degreeViewFontStyle];
        
        CGFloat height = self.frame.size.height - value * self.frame.size.height / _maxValue - size.height / 2;
        
        if (i == 0) {
            height = self.frame.size.height - size.height;
        } else if (i == _zChartsStyle.rowCount - 1) {
            height = 0;
        }
        
        [self drawText:CGPointMake(self.frame.size.width - size.width, height) text:text fontSize:_zChartsStyle.degreeViewFontStyle];
    }
}

- (void)setMaxValue:(int)maxValue {
    _maxValue = maxValue;
    [self setNeedsDisplay];
}



@end
