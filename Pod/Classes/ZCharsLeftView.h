//
//  ZCharsLeftView.h
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCharsKit.h"
@interface ZCharsLeftView : UIView


/**
 *  刻度数组
 */
//@property (nonatomic, assign) NSArray *valueData;

///**
// * 右侧间距
// */
//@property (nonatomic, assign) UIEdgeInsets rightInsets;


/**
 *  数值对应的 view 比例
 */
//@property (nonatomic, assign) CGFloat ratio;

/**
 *  字体数组
 */
@property (nonatomic, strong) NSDictionary *fontDict;


/**
 *  最大值和最小值区间
 */
//@property (nonatomic, assign) ZChasValue valueSection;


@end
