//
//  ZCharsBaseViewCell.h
//  IOSLib
//
//  Created by zhuayi on 8/16/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCharsKit.h"
//#import "ZCharsModel.h"
#import "ZCharsDelegate.h"

@interface ZCharsBaseViewCell : UICollectionViewCell


@property (nonatomic, weak) id<ZCharsDataSource> delegate;

/**
 *  cell row
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  X轴字体
 */
@property (nonatomic, strong) NSDictionary *XAxisFont;


/**
 *  绘制 X 轴
 *
 *  @param text
 */
- (void)drawXAxis:(NSString *)text;


@end
