//
//  ZChartsBaseView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBaseView.h"

/**
 *  比较两个参数数值大小
 *
 *  @param obj1 参数1
 *  @param obj2 参数2
 *
 *  @return NSComparator 对比结果
 */
NSComparator cmptr = ^(id obj1, id obj2){
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

const static CGFloat lineGap = 2.0;

@implementation ZChartsBaseView
{
    UILabel *paopaoLabel;
    
    // 显示多少行
    int _rowCount;
    
    // 每行的高度
    CGFloat _rowHeight;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 默认间距15
        _chartsViewMargin = CGPointMake(30, 15);
        
        _zChartsScrollView = [[ZChartsScrollView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 30)];
        
        _zChartsScrollView.delegate = self;
        
        [self addSubview:_zChartsScrollView];
        
        paopaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, 60, 20)];
        paopaoLabel.textAlignment = NSTextAlignmentCenter;
        paopaoLabel.font = [UIFont systemFontOfSize:12.f];
        paopaoLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:paopaoLabel];
        
        _zchartsBackgroundView = [[ZChartsBackgroundView alloc] initWithFrame:CGRectMake(
                                                                                        0,
                                                                                        0,
                                                                                        self.frame.size.width,
                                                                                        self.frame.size.height - 20
                                                                                        )];
        _zchartsBackgroundView.userInteractionEnabled = NO;
        _zchartsBackgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:_zchartsBackgroundView];
        
        // 默认显示4行
        _rowCount = 5;
        
    }
    return self;
}

//- (void)setChartsViewMargin:(CGPoint)chartsViewMargin
//{
//    _chartsViewMargin = chartsViewMargin;
//    
//    zchartsBackgroundView.chartsViewMargin = chartsViewMargin;
//    
//    _zChartsScrollView.frame = CGRectMake(0,
//                                          10,
//                                          self.frame.size.width,
//                                          self.frame.size.height - 10);
//    
//    paopaoLabel.frame = CGRectMake(0, self.frame.size.height - 20, 30, 20);
//}


- (void)setLineColor:(CGColorRef)lineColor
{
    _lineColor = lineColor;
    _zchartsBackgroundView.lineColor = _lineColor;
}

- (void)setDrawTextColor:(UIColor *)drawTextColor
{
    _drawTextColor = drawTextColor;
    _zchartsBackgroundView.drawTextColor = _drawTextColor;
}

- (void)setLegendData:(NSMutableArray *)legendData {
    if (!_legendData) {
        
        _legendData = [NSMutableArray arrayWithCapacity:0];
    }
    _legendData = legendData;
    
    // 获取最大值
    CGFloat maxData = [[[legendData sortedArrayUsingComparator:cmptr] lastObject] floatValue];
    NSString *maxDataString = [NSString stringWithFormat:@"%0.f", maxData];
    maxData = maxData / powf(10, [maxDataString length] - 1);
   
    maxData = ((int)maxData + 1) * pow(10, [maxDataString length] - 1);
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 赋值对象
    for (int i = 0; i< legendData.count; i++) {
        
        ZChartsModel *models = [[ZChartsModel alloc] init];
        models.value = [[legendData objectAtIndex:i] floatValue];
        models.point = CGPointMake(i * (_zChartsScrollView.barWidth + lineGap), models.value * _zChartsScrollView.frame.size.height / maxData);
        [array addObject:models];
    }
    _zChartsScrollView.barData = array;

    _zChartsScrollView.contentSize = CGSizeMake(legendData.count * (_zChartsScrollView.barWidth + 1.0),
                                                _zChartsScrollView.frame.size.height);

    _zchartsBackgroundView.maxValue = maxData;
    
    _zchartsBackgroundView.rowCount = _rowCount;
    [_zchartsBackgroundView setNeedsDisplay];
}

/**
 *  设置 paopaoview X 轴坐标
 *
 *  @param scrollView
 */
- (void)setPaopaoViewX:(UIScrollView*)scrollView {
    
    CGFloat maxContentOffset = scrollView.contentSize.width - scrollView.frame.size.width;
    CGRect frame = paopaoLabel.frame;
    frame.origin.x = (_zChartsScrollView.frame.size.width - paopaoLabel.frame.size.width / 2 )  * scrollView.contentOffset.x / maxContentOffset;
    if ( scrollView.contentOffset.x < 0) {
        
        frame.origin.x = 0 - scrollView.contentOffset.x - paopaoLabel.frame.size.width / 2;
    }
    else if ( scrollView.contentOffset.x > (scrollView.contentSize.width - scrollView.frame.size.width)) {
        
        frame.origin.x = _zChartsScrollView.frame.size.width - (scrollView.contentOffset.x - maxContentOffset) - paopaoLabel.frame.size.width / 2;
    }
    
    paopaoLabel.frame = frame;
    
    // 当前坐标点
    float currentX = scrollView.contentOffset.x + paopaoLabel.frame.origin.x + paopaoLabel.frame.size.width / 2;
    for (ZChartsModel *models in _zChartsScrollView.barData) {
        if (currentX >= models.point.x - lineGap && currentX <= (models.point.x + _zChartsScrollView.barWidth + lineGap)) {
            paopaoLabel.text = [NSString stringWithFormat:@"%0.f",models.value];
            models.isSelect = YES;
            [_zChartsScrollView.barChartsView setNeedsDisplay];
        } else {
            models.isSelect = NO;
        }
    }
}

#pragma mark - scrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView*)scrollView {
    
    [self setPaopaoViewX:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setPaopaoViewX:scrollView];
}

@end
