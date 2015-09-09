//
//  ZCharsKit.h
//  IOSLib
//
//  Created by zhuayi on 8/15/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZCharsType) {
    ZCharsTypeLine, // 曲线图
};


/* ZChasValue. */
struct ZChasValue {
    CGFloat minValue;
    CGFloat maxValue;
};
typedef struct ZChasValue ZChasValue;


CG_INLINE ZChasValue
ZChasValueMake(CGFloat minValue, CGFloat maxValue) {
    ZChasValue p; p.minValue = minValue; p.maxValue = maxValue; return p;
}


