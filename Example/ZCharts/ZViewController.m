//
//  ZViewController.m
//  ZCharts
//
//  Created by renxin on 04/18/2015.
//  Copyright (c) 2014 renxin. All rights reserved.
//

#import "ZViewController.h"
#import "ZChartsBaseView.h"
#import "ZChartsScrollView.h"

@implementation ZViewController
{
    ZChartsBaseView *zChartsView;
}
- (void)viewDidLoad
{
    zChartsView = [[ZChartsBaseView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    zChartsView.backgroundColor = [UIColor blackColor];
    zChartsView.lineColor = [UIColor redColor].CGColor;
    zChartsView.drawTextColor = [UIColor redColor];
    //    zChartsView.chartsViewMargin = CGPointMake(30, 0);
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i< 24; i++) {
        
        NSString *value = [NSString stringWithFormat:@"%d", [self getRandomNumber:100 to:500]];
        [data addObject:value];
    }
    zChartsView.legendData = data;
    
    
    [self.view addSubview:zChartsView];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 80, 80)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"刷新数据" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(resetData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)resetData {
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i< 24; i++) {
        
        NSString *value = [NSString stringWithFormat:@"%d",[self getRandomNumber:0 to:500]];
        [data addObject:value];
    }
    zChartsView.legendData = data;
    //    [zChartsView setNeedsDisplay];
}


-(int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from +1)));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
