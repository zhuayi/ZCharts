//
//  ZChartsBaseView.m
//  zCharts
//
//  Created by zhuayi on 15/4/13.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBaseView.h"
#import "UIView+ZQuartz.h"
/**
 *  比较两个参数数值大小
 *
 *  @param obj1 参数1
 *  @param obj2 参数2
 *
 *  @return NSComparator 对比结果
 */
NSComparator cmptr = ^(id obj1, id obj2){
    if ([[obj1 objectForKey:@"value"] integerValue] > [[obj2 objectForKey:@"value"] integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([[obj1 objectForKey:@"value"] integerValue] < [[obj2 objectForKey:@"value"] integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};


@implementation ZChartsBaseView
{
    UILabel *paopaoLabel;
    
    // 每行的高度
    CGFloat _rowHeight;
    
    // 最后一个有数据的 bar
    CGFloat _lastBar;
}

- (instancetype)initWithFrame:(CGRect)frame zChartsStyle:(ZChartsStyle *)zChartsStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _zChartsStyle = zChartsStyle;
        
        // 创建刻度 view
        _zchartsDegreeView = [[ZChartsDegreeView alloc] initWithFrame:CGRectMake(0, 0, _zChartsStyle.degreeViewWidth,  self.frame.size.height)];
        _zchartsDegreeView.zChartsStyle = zChartsStyle;
        _zchartsDegreeView.backgroundColor = [UIColor clearColor];
        [self addSubview:_zchartsDegreeView];
        
        _zChartsScrollView = [[ZChartsScrollView alloc] initWithFrame:CGRectMake(_zChartsStyle.degreeViewWidth + _zChartsStyle.degreeViewMarginRight, 0, self.frame.size.width - _zChartsStyle.degreeViewWidth - _zChartsStyle.degreeViewMarginRight, self.frame.size.height)];
        _zChartsScrollView.zChartsStyle = zChartsStyle;
        _zChartsScrollView.delegate = self;
        [self addSubview:_zChartsScrollView];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (ZChartsStyle *)zChartsStyle {
    if (!_zChartsStyle) {
        _zChartsStyle = [[ZChartsStyle alloc] init];
    }
    return _zChartsStyle;
}

- (void)setLegendData:(NSMutableArray *)legendData {
    _legendData = legendData;
    
    NSInteger count = 0;
    CGFloat maxData;
    if (_legendData != nil) {
        
        // 获取最大值
        maxData = [[[[_legendData sortedArrayUsingComparator:cmptr] lastObject] objectForKey:@"value"] floatValue];
        NSString *maxDataString = [NSString stringWithFormat:@"%0.f", maxData];
        maxData = maxData / powf(10, [maxDataString length] - 1);
        
        maxData = ((int)maxData + 1) * pow(10, [maxDataString length] - 1);
        //        if (maxData > _zChartsStyle.degreeminValue) {
        maxData = _zChartsStyle.degreemaxValue;
        //        }
        
        count = _legendData.count;
        
    } else  {
        count = 0;
        maxData = _zChartsStyle.degreemaxValue;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    _lastBar = 0;
    // 赋值对象
    for (int i = 0; i< count; i++) {
        ZChartsModel *models = [[ZChartsModel alloc] init];
        models.value = [[[_legendData objectAtIndex:i] objectForKey:@"value"] floatValue];
        if (models.value > 0) {
            _lastBar = i;
        }
        models.key = [[_legendData objectAtIndex:i] objectForKey:@"key"];
        models.point = CGPointMake(i * (_zChartsStyle.barWidth + _zChartsStyle.minimumRowSpacing), models.value * self.frame.size.height / maxData);
        [array addObject:models];
    }
    _zChartsScrollView.barData = array;
    _zChartsScrollView.contentSize = CGSizeMake(count * (_zChartsStyle.barWidth + _zChartsStyle.minimumRowSpacing), self.frame.size.height);
    _zchartsDegreeView.maxValue = maxData;
}

/**
 *  设置 paopaoview X 轴坐标
 *
 *  @param scrollView
 */
- (void)setPaopaoViewX:(UIScrollView*)scrollView {
    
    CGFloat maxContentOffset = scrollView.contentSize.width  - scrollView.frame.size.width;
    CGFloat contentOffsetScale = (scrollView.contentOffset.x ) / maxContentOffset;
    
    ZChartsModel *selectZChartsModel = [[ZChartsModel alloc] init];
    
    // 当前坐标点
    float currentX = scrollView.contentOffset.x + (scrollView.frame.size.width - _zChartsStyle.padding * 2) * contentOffsetScale;
    
    if (currentX < 0) {
        
        currentX = 0 ;
    } else if (currentX > (scrollView.contentSize.width - _zChartsStyle.padding * 2)) {
        
        currentX = scrollView.contentSize.width - _zChartsStyle.padding * 2;
    }
    
    for (ZChartsModel *models in _zChartsScrollView.barData) {
        if (currentX >= models.point.x && currentX <= (models.point.x + _zChartsStyle.barWidth + _zChartsStyle.minimumRowSpacing)) {
            paopaoLabel.text = [NSString stringWithFormat:@"%0.f",models.value];
            models.isSelect = YES;
            selectZChartsModel = models;
            
        } else {
            models.isSelect = NO;
        }
    }
    
    [_zChartsScrollView.barChartsView setNeedsDisplay];
    
    [_delegate scrollViewDidScroll:contentOffsetScale zChartsModel:selectZChartsModel];
}

/**
 *  滚动到第几个柱子
 *
 *  @param barIndex 柱子索引
 */
- (void)scrollToItemAtBarIndex:(NSInteger)barIndex animated:(BOOL)animated {
    
    
    CGFloat left = barIndex * ((_zChartsScrollView.contentSize.width - _zChartsScrollView.frame.size.width) / _legendData.count);
    
    if (left > (_zChartsScrollView.contentSize.width - _zChartsScrollView.frame.size.width)) {
        left = _zChartsScrollView.contentSize.width - _zChartsScrollView.frame.size.width;
    }
    
    CGPoint contentOffset = CGPointMake(left + _zChartsStyle.barWidth / 2 , 0);
    if (floorf(contentOffset.x) == floorf(_zChartsScrollView.contentOffset.x)) {
        [_zChartsScrollView setContentOffset:CGPointMake(contentOffset.x - 1 ,contentOffset.y - 1) animated:NO];
    }
    [_zChartsScrollView setContentOffset:contentOffset animated:animated];
}

/**
 *  滚动到最后一个有数据的 bar
 */
- (void)scrollToItemAtLastBar {
    [self scrollToItemAtBarIndex:_lastBar animated:NO];
}


#pragma mark - scrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView*)scrollView {
    
    [self setPaopaoViewX:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setPaopaoViewX:scrollView];
}


@end
