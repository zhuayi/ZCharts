//
//  ZCharsManager.m
//  IOSLib
//
//  Created by zhuayi on 8/14/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCharsManager.h"

#import "ZCharsLineViewCell.h"

/**
 *  比较两个参数数值大小
 *
 *  @param obj1 参数1
 *  @param obj2 参数2
 *
 *  @return NSComparator 对比结果
 */
NSComparator cmptr = ^(id obj1, id obj2){
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierHeader = @"HeaderView";
@interface ZCharsManager ()

/**
 *  左侧刻度数组
 */
@property (nonatomic, strong) NSMutableArray *leftValueArray;

/**
 *  滑块 view
 *  只可改变 paopaoview 的width 和 Y. 属性
 */
@property (nonatomic, strong) UIImageView *paopaoView;

@end

@implementation ZCharsManager {
    
    // 如果是绘制线条, 则需要设置绘制几条线
    NSInteger _lineNumer;
    
    // 数据数
//    NSInteger _dataCount;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _rightView = [[ZCharsRightView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [ZCharsStyle sharedManager].viewHeight = frame.size.height;
        
        _rightView.showsHorizontalScrollIndicator = NO;
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.dataSource = self;
        _rightView.delegate = self;
        [self addSubview:_rightView];
        
        _leftView = [[ZCharsLeftView alloc] initWithFrame:CGRectMake(0, 0, 30, self.frame.size.height)];
        [self addSubview:_leftView];
        
        // 默认曲线图
        self.zcharsType = ZCharsTypeLine;
        
    }
    return self;
}

- (void)setDelegate:(id<ZCharsManagerDelegate>)delegate {
    _delegate = delegate;
    
    // 设置行数
    [ZCharsStyle sharedManager].rowCount = [_delegate rowContInZCharsManager:self];
    
    // 设置列宽
    [ZCharsStyle sharedManager].columnWidth = [_delegate columnWidthInZCharsManager:self];
    
    // 设置刻度最大值和最小值
    if ([_delegate respondsToSelector:@selector(valueSectionInZCharsManager:)]) {
        
        [ZCharsStyle sharedManager].valueSection = [_delegate valueSectionInZCharsManager:self];
    }
    
    // 设置间距
    [ZCharsStyle sharedManager].rightInsets = [_delegate rightInsetsInZCharsManager:self];
    
    if ([_delegate respondsToSelector:@selector(paopaoViewInZCharsManager:)]) {
        
        _paopaoView = [_delegate paopaoViewInZCharsManager:self];
        [self addSubview:_paopaoView];
    }

}

- (void)setDataSource:(id<ZCharsDataSource>)dataSource {
    _dataSource = dataSource;
    [ZCharsStyle sharedManager].dataCount = [_dataSource collectionView:_rightView numberOfItemsInSection:1];
}

/**
 *  设置绘图类型
 *
 *  @param zcharsType
 */
- (void)setZcharsType:(ZCharsType)zcharsType {
    _zcharsType = zcharsType;
    
    if (_zcharsType == ZCharsTypeLine) {
        
        [_rightView registerClass:[ZCharsLineViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
}


/**
 *  设置 paopaoview 的位置
 *
 *  @param scrollView
 */
- (void)setPaopaoViewX:(UIScrollView*)scrollView {

    CGFloat maxWidth = self.frame.size.width - [ZCharsStyle sharedManager].rightInsets.left - [ZCharsStyle sharedManager].rightInsets.right;
    CGFloat contentOffsetScale = scrollView.contentOffset.x / (scrollView.contentSize.width  - scrollView.frame.size.width);
    
    CGRect frame = _paopaoView.frame;
    frame.origin.x = [ZCharsStyle sharedManager].rightInsets.left + contentOffsetScale * maxWidth - frame.size.width / 2;
    if (scrollView.contentOffset.x < 0) {
        frame.origin.x = [ZCharsStyle sharedManager].rightInsets.left - scrollView.contentOffset.x - frame.size.width / 2;
    }

    _paopaoView.frame = frame;
//
    
    int key = floor(contentOffsetScale * [ZCharsStyle sharedManager].dataCount);
    if (key < 0) {
        key = 0;
    } else if (key >= [ZCharsStyle sharedManager].dataCount) {
        key = (int)([ZCharsStyle sharedManager].dataCount - 1);
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:key inSection:0];
    if ([ZCharsStyle sharedManager].dataCount > 0) {
        [_delegate didScrollViewDidScroll:indexPath paopaoView:_paopaoView];
    }
    
}

- (void)scrollToBottom {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_rightView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:([ZCharsStyle sharedManager].dataCount - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

        [self setPaopaoViewX:_rightView];
    });
}

- (void)didMoveToWindow {

    [self scrollToBottom];
    
}

- (void)reloadData {
    
    _leftValueArray = nil;
    
    [_leftView setNeedsDisplay];
    [_rightView reloadData];
    [self scrollToBottom];
}

#pragma mark collectionView delegate

// item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row + 1 >= [ZCharsStyle sharedManager].dataCount) {
        return CGSizeMake(20, self.frame.size.height);
    }
    return CGSizeMake([ZCharsStyle sharedManager].columnWidth, self.frame.size.height);
}

// item间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [ZCharsStyle sharedManager].rightInsets.left, 0, [ZCharsStyle sharedManager].rightInsets.right);
}


// item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCharsBaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.XAxisFont = _rightView.XAxisFont;
    
    cell.delegate = _dataSource;
    
    cell.indexPath = indexPath;
    
    // 绘制曲线图
    if (_zcharsType == ZCharsTypeLine) {
        if (_lineNumer == 0) {
            _lineNumer = [cell.delegate lineNumberOfInZCharsManager:self];
        }
        
        ((ZCharsLineViewCell *)cell).lineNumer = _lineNumer;
    }
    
    [cell setNeedsDisplay];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [ZCharsStyle sharedManager].dataCount;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView*)scrollView {
    
    [self setPaopaoViewX:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setPaopaoViewX:scrollView];
}

- (void)dealloc {
    
    [ZCharsStyle dellocInstance];
    
    NSLog(@"%s", __func__);
}

@end
