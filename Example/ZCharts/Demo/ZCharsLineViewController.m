//
//  ZCharsLineViewController.m
//  IOSLib
//
//  Created by zhuayi on 9/8/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsLineViewController.h"
#import "ZCharsManager.h"


// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ZCharsLineViewController ()<ZCharsManagerDelegate,ZCharsDataSource>

@end

@implementation ZCharsLineViewController {
    
    UILabel *dataLabel;
    
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"曲线图";
    
    dataArray = @[
                  @{
                      @"data": @[@(120), @(132), @(101), @(134), @(90), @(230), @(210)],
                      @"unit": @"°C",
                      @"xAxis": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]
                    },
                  @{
                      @"data": @[@(-1), @(182), @(191), @(234), @(290), @(330), @(310)],
                      @"unit": @"°C",
                      @"xAxis": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]
                    }
                  ];

    ZCharsManager *zcharsManager = [[ZCharsManager alloc] initWithFrame:CGRectMake(0, 20, self.view.frame
                                                                                   .size.width, 200)];
    
    zcharsManager.zcharsType = ZCharsTypeLine;
    
    zcharsManager.delegate = self;
    zcharsManager.dataSource = self;
    // 设置左侧刻度样式
    zcharsManager.leftView.backgroundColor = [UIColor whiteColor];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    NSDictionary *fontDict = @{
                               NSFontAttributeName :            [UIFont systemFontOfSize:10.0],
                               NSForegroundColorAttributeName : UIColorFromRGB(0xa0a0a0),
                               NSParagraphStyleAttributeName:    paragraph
                               };
    zcharsManager.leftView.fontDict = fontDict;
//    zcharsManager.leftView.width = 35;
 
    zcharsManager.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ZCharsBg"]];
//    zcharsManager.leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ZCharsBg"]];

    NSMutableParagraphStyle *paragraph2 = [[NSMutableParagraphStyle alloc] init];
    paragraph2.alignment = NSTextAlignmentLeft;
    NSDictionary *fontDict2 = @{
                                NSFontAttributeName :            [UIFont systemFontOfSize:10.0],
                                NSForegroundColorAttributeName : UIColorFromRGB(0xa0a0a0),
                                NSParagraphStyleAttributeName:    paragraph2
                                };
    zcharsManager.rightView.XAxisFont = fontDict2;
    
    [self.view addSubview:zcharsManager];
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [zcharsManager reloadData];
    });
}


#pragma mark ZCharsManagerDelegate

- (void)didScrollViewDidScroll:(NSIndexPath *)indexPath paopaoView:(UIImageView *)paopaoView {
    
    if (dataLabel == nil) {
        dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, paopaoView.frame.size.width, 21)];
        dataLabel.font = [UIFont systemFontOfSize:12.0];
        dataLabel.textColor = UIColorFromRGB(0xffffff);
        [paopaoView addSubview:dataLabel];
    }
    dataLabel.text = [NSString stringWithFormat:@"%@   %@%@",
                      dataArray[1][@"xAxis"][indexPath.row],
                      dataArray[1][@"data"][indexPath.row],
                      dataArray[1][@"unit"]];
    
    //    NSLog(@"zcharsModelArray %@", ((ZCharsModel *)zcharsModelArray[0]).value);
}

- (NSInteger)rowContInZCharsManager:(ZCharsManager *)zcharsManager {
    
    return 5;
}

- (CGFloat)columnWidthInZCharsManager:(ZCharsManager *)zcharsManager {
    
    return 60;
}

- (ZChasValue)valueSectionInZCharsManager:(ZCharsManager *)zcharsManager {
    
    return ZChasValueMake(0, 400);
}


- (UIEdgeInsets)rightInsetsInZCharsManager:(ZCharsManager *)zcharsManager {
    
    return UIEdgeInsetsMake(0, 70, 45, 45);
}

- (UIImageView *)paopaoViewInZCharsManager:(ZCharsManager *)zcharsManager {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZcharsPaopao"]];
}

- (NSString *)headerViewInZCharsManager:(ZCharsManager *)zcharsManager {
    return @"ZCharsHeaderView";
}

#pragma mark - ZCharsDataSource
- (NSInteger)lineNumberOfInZCharsManager:(ZCharsManager *)zcharsManager {
    return dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [dataArray[section][@"data"] count];
}

- (CGFloat)dataOflineNumberZCharsManager:(NSIndexPath *)indexPath lineNumber:(NSInteger)lineNumber {
    return [dataArray[lineNumber][@"data"][indexPath.row] floatValue];
//    ZChasValue value = {
//        [dataArray[lineNumber][@"data"][cell.indexPath.row] floatValue],
//        [dataArray[lineNumber][@"data"][cell.indexPath.row + 1] floatValue]
//    };
    
//    return value;
}

- (NSString *)xAxisOflineNumberZCharsManager:(ZCharsLineViewCell *)cell lineNumber:(NSInteger)lineNumber {
    
    return dataArray[lineNumber][@"xAxis"][cell.indexPath.row];
}

- (UIColor *)lineColorOflineNumber:(NSInteger)lineNumber {
    
    if (lineNumber == 0) {
        return UIColorFromRGB(0xff6600);
    } else {
        return UIColorFromRGB(0x0099ff);
    }
    
}

@end
