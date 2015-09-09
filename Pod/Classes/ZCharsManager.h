//
//  ZCharsManager.h
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCharsKit.h"
#import "ZCharsLeftView.h"
#import "ZCharsDelegate.h"
#import "ZCharsRightView.h"
#import "ZCharsLineViewCell.h"
#import "ZCharsStyle.h"

@interface ZCharsManager : UIView<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, weak) id<ZCharsManagerDelegate> delegate;

/**
 *  数据代理
 */
@property (nonatomic, weak) id<ZCharsDataSource> dataSource;

/**
 *  绘图类型
 */
@property (nonatomic, assign) ZCharsType zcharsType;


/**
 *  左侧 view
 */
@property (nonatomic, strong) ZCharsLeftView *leftView;


/**
 *  右侧 view
 */
@property (nonatomic, strong) ZCharsRightView *rightView;


/**
 *  刷新数据
 */
- (void)reloadData;

@end
