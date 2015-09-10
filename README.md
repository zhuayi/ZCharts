# ZCharts

[![CI Status](http://img.shields.io/travis/zhuayi/ZCharts.svg?style=flat)](https://travis-ci.org/zhuayi/ZCharts) [![Version](https://img.shields.io/cocoapods/v/ZCharts.svg?style=flat)](http://cocoapods.org/pods/ZCharts) [![License](https://img.shields.io/cocoapods/l/ZCharts.svg?style=flat)](http://cocoapods.org/pods/ZCharts) [![Platform](https://img.shields.io/cocoapods/p/ZCharts.svg?style=flat)](http://cocoapods.org/pods/ZCharts)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

IOSLib is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZChars', :git => 'https://github.com/zhuayi/ZCharts.git'
```

## Example

```objectice-c
#import "ZCharsManager.h"
```

### 准备数据
```objective-c

dataArray = @[
    @{
        @"data": @[@(120), @(132), @(101), @(134), @(90), @(230), @(210)],
        @"unit": @"°C",
        @"xAxis": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]
    },
    @{
        @"data": @[@(-1), @(182), @(191), @(234), @(290), @(330), @(310)],
        @"unit": @"°C",
        @"xAxis": @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]
    }
];

// 
ZCharsManager *zcharsManager = [[ZCharsManager alloc] initWithFrame:CGRectMake(0, 20, self.view.frame
.size.width, 200)];

// 设置代理
zcharsManager.delegate = self;
zcharsManager.dataSource = self;
[self.view addSubview:zcharsManager];

// 选择绘制类型为曲线图
zcharsManager.zcharsType = ZCharsTypeLine;
```

###ZCharsManagerDelegate

**行数**
```objective-c
- (NSInteger)rowContInZCharsManager:(ZCharsManager *)zcharsManager;
```

**每列宽度**
```objective-c
- (CGFloat)columnWidthInZCharsManager:(ZCharsManager *)zcharsManager;
```

**刻度区间, 最大值,最小值, 不设置则自动计算**
```objective-c
- (ZChasValue)valueSectionInZCharsManager:(ZCharsManager *)zcharsManager;
```

**间距**
```objective-c
- (UIEdgeInsets)rightInsetsInZCharsManager:(ZCharsManager *)zcharsManager;
```

**滑块 view**
```objective-c
- (UIImageView *)paopaoViewInZCharsManager:(ZCharsManager *)zcharsManager;
```

###ZCharsDataSource

**line模式下 每个 cell 绘制几条线**
```objective-c
- (NSInteger)lineNumberOfInZCharsManager:(ZCharsManager *)zcharsManager;
```

**线条颜色**
```objective-c
- (UIColor *)lineColorOflineNumber:(NSInteger)lineNumber
```

**曲线图数据**
```objective-c
- (CGFloat)dataOflineNumberZCharsManager:(NSIndexPath *)indexPath lineNumber:(NSInteger)lineNumber;
```

**X轴绘制文字**
```objective-c
- (NSString *)xAxisOflineNumberZCharsManager:(ZCharsLineViewCell *)cell lineNumber:(NSInteger)lineNumber
```

### 曲线图
![enter image description here](https://raw.githubusercontent.com/zhuayi/ZCharts/master/line.gif)

## Author

zhuayi, 2179942@qq.com

## License

IOSLib is available under the MIT license. See the LICENSE file for more info.