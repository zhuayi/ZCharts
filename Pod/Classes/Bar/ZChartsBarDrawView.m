//
//  ZBarChars2.m
//  zCharts
//
//  Created by zhuayi on 15/4/10.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBarDrawView.h"
#import "ZChartsModel.h"
#import "UIView+ZQuartz.h"
#define kFrameRate 1 / 20.f

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

- (void)setBarData:(NSMutableArray *)barData {
    _barData = barData;
    _currentTime = 0;
    [self starAnimation];
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
        
        [self drawRectangle:frame lineWidth:lineWidth color:[UIColor whiteColor]];
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
    currentTime = currentTime * (kFrameRate);
    toValue = toValue - fromValue;
    duration = duration / (kFrameRate);
    return  (currentTime >= duration) ? fromValue + toValue : toValue * (-pow(2, -10 * currentTime / duration) + 1) + fromValue;
}

@end
