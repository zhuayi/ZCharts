//
//  ZCharsDelegate.h
//  IOSLib
//
//  Created by zhuayi on 8/17/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCharsKit.h"
//#import "ZCharsLineViewCell.h"

@class ZCharsManager;
@class ZCharsLineViewCell;

@protocol ZCharsManagerDelegate <NSObject>

- (void)didScrollViewDidScroll:(NSIndexPath *)indexPath paopaoView:(UIImageView *)paopaoView;

/**
 *  行数
 *
 *  @param zcharsManager
 *  @param rowCount
 *
 *  @return
 */
- (NSInteger)rowContInZCharsManager:(ZCharsManager *)zcharsManager;

/**
 *  每列宽度
 *
 *  @param zcharsManager
 *
 *  @return
 */
- (CGFloat)columnWidthInZCharsManager:(ZCharsManager *)zcharsManager;


/**
 *  刻度区间, 最大值,最小值, 不设置则自动计算
 *
 *  @param zcharsManager
 *
 *  @return
 */
- (ZChasValue)valueSectionInZCharsManager:(ZCharsManager *)zcharsManager;


/**
 *  间距
 *
 *  @param zcharsManager
 *
 *  @return 
 */
- (UIEdgeInsets)rightInsetsInZCharsManager:(ZCharsManager *)zcharsManager;

/**
 *  滑块 view
 *  只可改变 paopaoview 的width 和 Y. 属性
 *
 *  @param zcharsManager
 *
 *  @return 
 */
- (UIImageView *)paopaoViewInZCharsManager:(ZCharsManager *)zcharsManager;

/**
 *  collectionView header
 *
 *  @param zcharsManager
 *
 *  @return
 */
- (NSString *)headerViewInZCharsManager:(ZCharsManager *)zcharsManager;


@end


@protocol ZCharsDataSource <NSObject>


//*********** lineDelegate ***************

/**
 *  每个 cell 绘制几条线
 *
 *  @param zcharsManager
 *
 *  @return
 */
- (NSInteger)lineNumberOfInZCharsManager:(ZCharsManager *)zcharsManager;

/**
 *  数据条数
 *
 *  @param collectionView
 *  @param section
 *
 *  @return 
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;


/**
 *  曲线图代理方法
 *
 *  @param cell
 *  @param lineNumber
 *
 *  @return
 */
- (CGFloat)dataOflineNumberZCharsManager:(NSIndexPath *)indexPath lineNumber:(NSInteger)lineNumber;

/**
 *  线条颜色
 *
 *  @param lineNumber <#lineNumber description#>
 *
 *  @return <#return value description#>
 */
- (UIColor *)lineColorOflineNumber:(NSInteger)lineNumber;

/**
 *  X轴绘制文字
 *
 *  @param cell
 *  @param lineNumber
 *
 *  @return
 */
- (NSString *)xAxisOflineNumberZCharsManager:(ZCharsLineViewCell *)cell lineNumber:(NSInteger)lineNumber;
@end
