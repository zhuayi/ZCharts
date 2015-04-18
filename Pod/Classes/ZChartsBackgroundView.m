//
//  ZChartsBackgroundView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBackgroundView.h"

@implementation ZChartsBackgroundView {
    CGContextRef _context;

    /**
     *   view 高度
     */
    CGFloat _viewHeight;
}

/**
 *  设置背景间距
 *
 *  @param chartsViewMargin 间距
 */
- (void)setChartsViewMargin:(CGPoint)chartsViewMargin {
    _chartsViewMargin = chartsViewMargin;
    _viewHeight = self.frame.size.height - _chartsViewMargin.y;
}

/**
 *  绘制层
 *
 *  @param rect  view尺寸
 */
- (void)drawRect:(CGRect)rect
{
    _context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(_context, self.lineColor);
    
//    CGContextMoveToPoint(_context, _chartsViewMargin.x, _chartsViewMargin.y / 2);
//    CGContextAddLineToPoint(_context, _chartsViewMargin.x, self.frame.size.height - _chartsViewMargin.y / 2);
//    CGContextMoveToPoint(_context, _chartsViewMargin.x, self.frame.size.height - _chartsViewMargin.y / 2);
//    CGContextAddLineToPoint(_context, self.frame.size.width, self.frame.size.height - _chartsViewMargin.y / 2);
//    CGContextStrokePath(_context);

    for (int i = 0; i < _rowCount; i++) {
        
        int value = _maxValue/(_rowCount - 1) * i;
        
        NSString *text = [NSString stringWithFormat:@"%d", value];
        CGSize size = [text sizeWithAttributes:[self fontStyle]];
        
        CGFloat height = self.frame.size.height - value * self.frame.size.height / _maxValue - size.height / 2;
        
        if (i == 0) {
            height = self.frame.size.height - size.height;
        } else if (i == _rowCount - 1) {
            height = 0;
        }
        
        [self drawText:CGPointMake(10 - size.width / 2, height) text:text];
    }
}

/**
 *  获取绘制文字样子
 *
 *  @return NSDictionary 文字样式
 */
- (NSDictionary *)fontStyle {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init]; // 段落样式
    style.alignment = NSTextAlignmentRight;
    NSDictionary *fontDict = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:10],
                               NSForegroundColorAttributeName: _drawTextColor,
                               NSParagraphStyleAttributeName: style
                               };
    
    return fontDict;
}

- (void)drawText:(CGPoint)point text:(NSString *)text
{
    // 兼容不同长度的字符串
    [text drawAtPoint:point withAttributes:[self fontStyle]];
}


@end
