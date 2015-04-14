//
//  ViewController.m
//  zCharts
//
//  Created by zhuayi on 15/4/3.
//  Copyright (c) 2015年 renxin. All rights reserved.
//

#import "ViewController.h"
#import "ZChartsBaseView.h"
#import "ZBarChartsScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    

    
    ZChartsBaseView *zChartsView = [[ZChartsBaseView alloc] initWithFrame:CGRectMake(0, 100, 320, 300)];
    zChartsView.backgroundColor = [UIColor redColor];
    
//    scroll.barWidth = 20;
//    ZBarChars2 *charts2 = [[ZBarChars2 alloc] initWithFrame:CGRectMake(0, 0, 500, 300)];
//    zChartsView.legendData = [NSMutableArray arrayWithArray:@[ @"301", @"402", @"503", @"604", @"750", @"806",@"907"]];
    zChartsView.legendData = [NSMutableArray arrayWithArray:@[ @"0.20", @"0.83", @"1.58", @"13.12", @"5.43"]];
//    [scroll addSubview:charts2];
    [self.view addSubview:zChartsView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
