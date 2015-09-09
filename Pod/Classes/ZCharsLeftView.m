//
//  ZCharsLeftView.m
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsLeftView.h"
#import "ZCharsStyle.h"
@implementation ZCharsLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSDictionary *)fontDict {
    if (_fontDict == nil) {
    
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentRight;
        _fontDict = @{
                        NSFontAttributeName :            [UIFont systemFontOfSize:18.0],
                        NSForegroundColorAttributeName : [UIColor redColor],
                        NSParagraphStyleAttributeName:    paragraph
                        };
    }
    return _fontDict;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat heightRadio = [ZCharsStyle sharedManager].drawHeight / [ZCharsStyle sharedManager].rowCount;
  
    CGSize textSize;
    for (int i = 0; i < [ZCharsStyle sharedManager].rowCount; i++) {

        CGFloat value = [ZCharsStyle sharedManager].valueSection.minValue + (([ZCharsStyle sharedManager].valueSection.maxValue - [ZCharsStyle sharedManager].valueSection.minValue) / ([ZCharsStyle sharedManager].rowCount - 1)) * i;
        
        NSString *text = [NSString stringWithFormat:@"%0.0f", value];
        
        @autoreleasepool {
            textSize = [text sizeWithAttributes:self.fontDict];
            
            [text drawInRect:CGRectMake(5,
                                        self.frame.size.height - heightRadio * i - textSize.height - [ZCharsStyle sharedManager].rightInsets.bottom,
                                        self.frame.size.width - 5,
                                        heightRadio)
              withAttributes:self.fontDict];
        }
    }

    [ZCharsStyle sharedManager].bottomSpace  = textSize.height;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
