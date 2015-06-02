//
//  ZViewController.m
//  ZCharts
//
//  Created by renxin on 04/18/2015.
//  Copyright (c) 2014 renxin. All rights reserved.
//

#import "ZViewController.h"

@implementation ZViewController
{
    ZChartsBaseView *zChartsView;
    UILabel *paopaoLabel;
}
- (void)viewDidLoad
{
    ZChartsStyle *zChartsStyle = [[ZChartsStyle alloc] init];
    zChartsStyle.degreeViewWidth = 20;
    zChartsStyle.rowCount = 5;
    zChartsStyle.barWidth = 10;
    zChartsStyle.padding = 50;
    zChartsStyle.duration = 0.6;
    zChartsStyle.degreemaxValue = 500;
    zChartsStyle.degreeViewFontStyle = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                                         NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2]
                                         };
    zChartsStyle.degreeViewMarginRight = 7;
    zChartsStyle.minimumRowSpacing = 2;
    
    zChartsView = [[ZChartsBaseView alloc] initWithFrame:CGRectMake(20, 100, 320 - 40, 204) zChartsStyle:zChartsStyle];
    zChartsView.delegate = self;
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i< 24 * 7; i++) {
        
        NSString *value = [NSString stringWithFormat:@"%d", [self getRandomNumber:100 to:500]];
        NSDictionary *dict = @{ @"key":[NSString stringWithFormat:@"%d", i], @"value":value};
        [data addObject:dict];
    }

//    zChartsView.legendData = data;
    
    
    [self.view addSubview:zChartsView];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 80, 80)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"刷新数据" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(resetData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.view.backgroundColor = [UIColor colorWithRed:39./255. green:158.0 / 255.0 blue:133.0 / 255.0 alpha:1.0];
    
    paopaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(zChartsView.frame.origin.x + (zChartsView.frame.size.width - zChartsStyle.degreeViewWidth) / 2, zChartsView.frame.origin.y + zChartsView.frame.size.height, 60, 20)];
    paopaoLabel.textAlignment = NSTextAlignmentCenter;
    paopaoLabel.font = [UIFont systemFontOfSize:12.f];
    paopaoLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:paopaoLabel];
}

- (void)resetData {
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i< 24 * 7; i++) {
        
        NSString *value = [NSString stringWithFormat:@"%d", [self getRandomNumber:500 to:1000]];
        NSDictionary *dict = @{ @"key":[NSString stringWithFormat:@"%d", i], @"value":value};
        [data addObject:dict];
    }

    zChartsView.legendData = data;
    [zChartsView setNeedsDisplay];
}

#pragma mark 
- (void)scrollViewDidScroll:(CGFloat)contentOffsetScale zChartsModel:(ZChartsModel *)zChartsModel{
    CGRect frame = paopaoLabel.frame;
    
    frame.origin.x = zChartsView.frame.origin.x + (zChartsView.zChartsScrollView.frame.size.width) * contentOffsetScale;
    paopaoLabel.frame = frame;
    NSLog(@"contentOffsetScale : key =%@ , value =%f", zChartsModel.key , zChartsModel.value);
}


-(int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from +1)));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
