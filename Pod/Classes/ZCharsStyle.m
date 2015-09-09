//
//  ZCharsStyle.m
//  IOSLib
//
//  Created by zhuayi on 9/9/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsStyle.h"

static ZCharsStyle *sharedAccountManagerInstance = nil;

@implementation ZCharsStyle


+ (ZCharsStyle *)sharedManager {
    
    @synchronized (self)
    {
        if (sharedAccountManagerInstance == nil)
        {
            sharedAccountManagerInstance = [[self alloc] init];
        }
    }
    return sharedAccountManagerInstance;
}

+ (void)dellocInstance {
    sharedAccountManagerInstance = nil;
}

- (CGFloat)drawHeight {
    
    return _viewHeight - [ZCharsStyle sharedManager].rightInsets.top - [ZCharsStyle sharedManager].rightInsets.bottom;
}

- (CGFloat)ratio {
    
    return  (_viewHeight - [ZCharsStyle sharedManager].rightInsets.top - [ZCharsStyle sharedManager].rightInsets.bottom) / [ZCharsStyle sharedManager].rowCount / (([ZCharsStyle sharedManager].valueSection.maxValue - [ZCharsStyle sharedManager].valueSection.minValue) / ([ZCharsStyle sharedManager].rowCount - 1));
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
