//
//  ZBarChars2.m
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBarDrawView.h"
#import "ZChartsModel.h"

#define kFrameRate 1/60.f

@implementation ZChartsBarDrawView
{
    CGContextRef _context;

    NSTimer *_timer;
    
    /**
     *  当前帧数
     */
    float _currentTime;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self starAnimation];
    }
    return self;
}

/**
 *  开始刷新 view
 */
- (void)starAnimation {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kFrameRate target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    }
}

/**
 *  停止动画
 */
- (void)stopAnimation {
    NSLog(@"stopAnimation");
//    _currentTime = 0;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (ZChartsStyle *)zChartsStyle {
    if (!_zChartsStyle) {
        _zChartsStyle = [[ZChartsStyle alloc] init];
    }
    return _zChartsStyle;
}

/**
 * 绘制
 *
 *  @param rect view 尺寸
 */
- (void)drawRect:(CGRect)rect {
    _context = UIGraphicsGetCurrentContext();

    BOOL isStopAnimation = NO;
    
    for (ZChartsModel *modes in _barData) {
        
        [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2] setFill];
        CGRect frame2 = CGRectMake(modes.point.x, 0, _zChartsStyle.barWidth, self.frame.size.height);
        [self drawRectangle:frame2 lineWidth:0.0];
        
        CGFloat y = [self getPostion:_currentTime fromValue:0 toValue:modes.point.y duration:_zChartsStyle.duration];
        if (y < modes.point.y) {
            isStopAnimation = YES;
        }
        
        CGRect frame = CGRectMake(modes.point.x, self.frame.size.height - y, _zChartsStyle.barWidth, modes.point.y);
        
        CGFloat lineWidth = 0.0;
        if (modes.isSelect) {
            lineWidth = 1.5;
        }
        
        if ([self respondsToSelector:@selector(drawCustom:)]) {
            
            [self performSelector:@selector(drawCustom:) withObject:modes];
        }
        
        [self drawRectangle:frame lineWidth:lineWidth];
    }
    _currentTime++;
    if (isStopAnimation == NO) {
        [self stopAnimation];
    }
}

/**
 *  计算下一帧坐标
 *
 *  @param currentTime 当前时间
 *  @param fromValue   起始位置
 *  @param toValue     目标位置
 *  @param duration    动画时间
 *
 *  @return CGFloat 坐标
 */
- (CGFloat)getPostion:(CGFloat)currentTime fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration
{
    currentTime = currentTime*kFrameRate;
    return  (currentTime >= duration) ? fromValue + toValue : toValue * (-pow(2, -10 * currentTime / duration) + 1) + fromValue;
}


///**
// *  设置柱状图数据
// *
// *  @param barData 柱状图数据
// */
//- (void)setBarData:(NSMutableArray *)barData {
//    _barData = barData;
//    [self starAnimation];
//}

/**
 *  绘制矩形
 *
 *  @param rect 矩形尺寸
 */
- (void)drawRectangle:(CGRect)rect lineWidth:(CGFloat)lineWidth{
    
    UIColor *aColor = [UIColor whiteColor];
    CGContextSetStrokeColorWithColor(_context, aColor.CGColor);//线框颜色
    CGContextSetLineWidth(_context, lineWidth);
    
    CGMutablePathRef pathRef = [self pathwithFrame:rect withRadius:0];
    
    CGContextAddPath(_context, pathRef);
    CGContextDrawPath(_context,kCGPathFillStroke);
    
    CGPathRelease(pathRef);
}

/**
 *  生成矩形路径
 *
 *  @param frame  矩形尺寸
 *  @param radius 圆角弧度
 *
 *  @return CGMutablePathRef 矩形路径
 */
- (CGMutablePathRef)pathwithFrame:(CGRect)frame withRadius:(float)radius
{
    CGPoint x1, x2, x3, x4; //x为4个顶点
    CGPoint y1, y2, y3, y4, y5, y6, y7, y8; //y为4个控制点
    //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
    
    x1 = frame.origin;
    x2 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    x3 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height);
    x4 = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
    
    
    y1 = CGPointMake(frame.origin.x + radius, frame.origin.y);
    y2 = CGPointMake(frame.origin.x + frame.size.width - radius, frame.origin.y);
    y3 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + radius);
    y4 = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height - radius);
    
    y5 = CGPointMake(frame.origin.x + frame.size.width-radius, frame.origin.y+frame.size.height);
    y6 = CGPointMake(frame.origin.x + radius, frame.origin.y + frame.size.height);
    y7 = CGPointMake(frame.origin.x, frame.origin.y + frame.size.height-radius);
    y8 = CGPointMake(frame.origin.x, frame.origin.y + radius);
    
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    if (radius<=0) {
        CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, x1.x, x1.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x2.x, x2.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x3.x, x3.y);
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, x4.x, x4.y);
    } else {
        CGPathMoveToPoint(pathRef,    &CGAffineTransformIdentity, y1.x, y1.y);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y2.x, y2.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x2.x, x2.y, y3.x, y3.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y4.x, y4.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x3.x, x3.y, y5.x, y5.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y6.x, y6.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x4.x, x4.y, y7.x, y7.y, radius);
        
        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, y8.x, y8.y);
        CGPathAddArcToPoint(pathRef, &CGAffineTransformIdentity,  x1.x, x1.y, y1.x, y1.y, radius);
    }
    CGPathCloseSubpath(pathRef);
    return pathRef;
}

@end
