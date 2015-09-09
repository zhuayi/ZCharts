//
//  ZCharsLineViewCell.m
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsLineViewCell.h"
#import "ZCharsStyle.h"
@implementation ZCharsLineViewCell {
    
    UIColor *_lineColor;
}

static float lineWidth = 2.0;

static float roundRadius = 4.0;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawLine:(CGContextRef)context data:(ZChasValue)data lineNumber:(NSInteger)lineNumber {

    ZChasValue zcharsValue = {
        (data.minValue - [ZCharsStyle sharedManager].valueSection.minValue) * [ZCharsStyle sharedManager].ratio,
        (data.maxValue - [ZCharsStyle sharedManager].valueSection.minValue) * [ZCharsStyle sharedManager].ratio
    };
    
    CGFloat minHeight = [ZCharsStyle sharedManager].drawHeight - zcharsValue.minValue;
    CGFloat maxHeight = [ZCharsStyle sharedManager].drawHeight - zcharsValue.maxValue;
    
    // 如果cell 的 end 值大于最小值, 就将 end 值替换成 start 值 modify by renxin 2015/08/24
    if (data.maxValue < [ZCharsStyle sharedManager].valueSection.minValue) {
        maxHeight = minHeight;
    }
    
    if (data.minValue > [ZCharsStyle sharedManager].valueSection.minValue ) {
    
        UIColor  *lineColor = [self.delegate lineColorOflineNumber:lineNumber];
        [lineColor set];
        
        CGContextSetLineWidth(context, lineWidth);//线的宽度
        
        CGContextMoveToPoint(context, roundRadius, minHeight);//设置Path的起点
        
        CGContextAddQuadCurveToPoint(context, self.frame.size.width / 2, maxHeight - (maxHeight - minHeight), self.frame.size.width, maxHeight);//设置贝塞尔曲线的控制点坐标和终点坐标
        
        CGContextStrokePath(context);
        

    }
}

/**
 *  画圆点
 *
 *  @param context
 *  @param starValue
 */
- (void)drawRound:(CGContextRef)context starValue:(CGFloat)starValue {
    CGFloat minHeight = [ZCharsStyle sharedManager].drawHeight - (starValue - [ZCharsStyle sharedManager].valueSection.minValue) * [ZCharsStyle sharedManager].ratio;
//    [_lineColor set];
    CGContextFillEllipseInRect(context, CGRectMake(0, minHeight - roundRadius, roundRadius * 2, roundRadius * 2));
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < _lineNumer; i++) {
        
        CGFloat starValue = [self.delegate dataOflineNumberZCharsManager:self.indexPath lineNumber:i];
        
        CGFloat endValue = 0;
        
        
        if (self.indexPath.row + 1 >= [ZCharsStyle sharedManager].dataCount) {
            
            UIColor  *lineColor = [self.delegate lineColorOflineNumber:i];
            [lineColor set];
            
            [self drawRound:context starValue:starValue];
            
        } else {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.indexPath.row + 1 inSection:0];
            endValue = [self.delegate dataOflineNumberZCharsManager:indexPath lineNumber:i];
            ZChasValue data = {starValue, endValue};
            [self drawLine:context data:data lineNumber:i];
            
            if (starValue > [ZCharsStyle sharedManager].valueSection.minValue ) {
                [self drawRound:context starValue:starValue];
            }
        }
  
        [self drawXAxis:[self.delegate xAxisOflineNumberZCharsManager:self lineNumber:i]];
    }
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
