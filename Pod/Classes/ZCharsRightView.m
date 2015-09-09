//
//  ZCharsBaseView.m
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsRightView.h"
#import "ZCharsLineViewCell.h"


@implementation ZCharsRightView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0.0;
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {        
        self.delegate = self;
    }
    return self;
}

//- (void)setBackgroundImage:(UIImage *)backgroundImage {
//    
//    UIImageView *imageBack = [[UIImageView alloc] initWithImage:backgroundImage];
//    imageBack.frame = CGRectMake(0, 0, 200, 327);
//    [self addSubview:imageBack];
//}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
