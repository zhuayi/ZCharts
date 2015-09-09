//
//  ZCharsBaseViewCell.m
//  IOSLib
//
//  Created by zhuayi on 8/16/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsBaseViewCell.h"
#import "ZCharsStyle.h"
@implementation ZCharsBaseViewCell


- (NSDictionary *)XAxisFont {
    if (_XAxisFont == nil) {
        
        _XAxisFont = @{
                        NSFontAttributeName :            [UIFont systemFontOfSize:18.0],
                        NSForegroundColorAttributeName : [UIColor redColor],
                        };
    }
    
    return _XAxisFont;
}

/**
 *  绘制 X 轴
 *
 *  @param text
 */
- (void)drawXAxis:(NSString *)text {
    
    CGSize textSize = [text sizeWithAttributes:self.XAxisFont];
    [text drawInRect:CGRectMake(0, self.frame.size.height  - textSize.height / 2 - [ZCharsStyle sharedManager].rightInsets.bottom / 2, self.frame.size.width, [ZCharsStyle sharedManager].rightInsets.bottom) withAttributes:self.XAxisFont];
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
