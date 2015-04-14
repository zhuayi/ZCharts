//
//  ZChartsBackgroundView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBackgroundView.h"

@implementation ZChartsBackgroundView
{
    CGContextRef _context;
}

/**
 *  绘制层
 *
 *  @param rect  view尺寸
 */
- (void)drawRect:(CGRect)rect
{
    _context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(_context, 1.0, 1.0, 1.0, 1);
    
    CGContextMoveToPoint(_context, _marginLeft, _marginLeft / 2);
    CGContextAddLineToPoint(_context, _marginLeft, self.frame.size.height - _marginLeft / 2);
    CGContextMoveToPoint(_context, _marginLeft, self.frame.size.height - _marginLeft / 2);
    CGContextAddLineToPoint(_context, self.frame.size.width, self.frame.size.height - _marginLeft / 2);
    CGContextStrokePath(_context);
    
    // 求最大值
    NSString *maxValueString = [NSString stringWithFormat:@"%d",_maxValue];
    _maxValue = _maxValue/pow(10, [maxValueString length] - 1);
    _maxValue = (_maxValue + 1) * pow(10, [maxValueString length] - 1);
    maxValueString = [NSString stringWithFormat:@"%d", _maxValue];
//
    int count = 5;
    for (int i = 1; i < count; i++) {
        int value;
        if (i == count) {
            value = 0;
        } else {
            value = _maxValue - _maxValue/count * i;
        }
        NSString *text = [NSString stringWithFormat:@"%d", value];
        CGSize size = [text sizeWithAttributes:[self fontStyle]];
        [self drawText:CGPointMake(_marginLeft - size.width - 3, self.frame.size.height - _heightScale * value - size.height / 2 - _marginLeft / 2) text:text];
    }
    
    // 绘制最大值
    CGSize  maxSize = [maxValueString sizeWithAttributes:[self fontStyle]];
    [self drawText:CGPointMake(_marginLeft - maxSize.width - 3, maxSize.height / 2) text:maxValueString];
    
    // 绘制最小值
    NSString *minText = [NSString stringWithFormat:@"%d", 0];
    CGSize  minSize = [minText sizeWithAttributes:[self fontStyle]];
    [self drawText:CGPointMake(_marginLeft - minSize.width - 3, self.frame.size.height - minSize.height - _marginLeft / 2) text:minText];
    
    
    
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
                               NSForegroundColorAttributeName: [UIColor darkGrayColor],
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
