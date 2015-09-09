//
//  ZCharsBaseView.h
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCharsKit.h"
@interface ZCharsRightView : UICollectionView<UICollectionViewDelegate>

/**
 *  X轴字体
 */
@property (nonatomic, strong) NSDictionary *XAxisFont;

/**
 *  背景
 */
@property (nonatomic, strong) UIImage *backgroundImage;


@end
