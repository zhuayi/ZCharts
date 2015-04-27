//
//  ZChartsBarDrawView+Custom.m
//  ZCharts
//
//  Created by zhuayi on 15/4/26.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ZChartsBarDrawView+Custom.h"
#import "ZChartsKit.h"
#import "UIView+ZQuartz.h"
@implementation ZChartsBarDrawView (Custom)


- (void)drawCustom:(ZChartsModel *)zChartsModel {
    
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.05] setFill];
    CGRect frame2 = CGRectMake(zChartsModel.point.x, 0, self.zChartsStyle.barWidth, self.frame.size.height);
    [self drawRectangle:frame2 lineWidth:0.0 color:[UIColor whiteColor]];
        
    [[UIColor blackColor] setFill];
}
@end
