# JLBannerView
[![Version](https://img.shields.io/cocoapods/v/JLBannerView.svg?style=flat)](http://cocoadocs.org/docsets/JLBannerView)
[![License](https://img.shields.io/cocoapods/l/JLBannerView.svg?style=flat)](http://cocoadocs.org/docsets/JLBannerView)
[![Platform](https://img.shields.io/cocoapods/p/JLBannerView.svg?style=flat)](http://cocoadocs.org/docsets/JLBannerView)
[![Support](https://img.shields.io/badge/support-iOS%208+-blue.svg?style=flat)](https://www.apple.com/nl/ios/)

## Features

## Install
**CocoaPods**
```ruby
platform :ios, '8.0'
pod 'JLBannerView'
```

## Usage
**Import header file**
```objc
#import <JLBannerView/JLBannerView.h>
```

**Code Example**
```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    JLBannerView *bannerView = [[JLBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    bannerView.delegate = self;
    bannerView.dataSource = self;
    [bannerView reloadData];
}

#pragma mark - JLBannerViewDataSource

- (NSInteger)numberOfItemsInBannerView:(JLBannerView *)bannerView {
    return 10;
}

- (UIView *)bannerView:(JLBannerView *)bannerView reusableItemView:(UIView *)reusableItemView forItemAtIndex:(NSInteger)index {    
    UILabel *label = (UILabel *)reusableItemView;
    if ([label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:35 weight:UIFontWeightMedium];
    }
    
    label.text = [NSString stringWithFormat:@"%zd",index];
    return label;
}

#pragma mark - JLBannerViewDelegate

- (void)bannerView:(JLBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"index : %zd",index);
}
```

**loop**
```objc
@property (nonatomic, assign) IBInspectable BOOL shouldLoop; // default is YES
```

**auto scrolling**
```objc
@property (nonatomic, assign) IBInspectable BOOL autoScrolling; // default is NO
@property (nonatomic, assign) IBInspectable CGFloat scrollInterval; // default is 5

```

## Todo
- [ ] Landscape mode support

## Licence
The MIT License (MIT)

Copyright (c) 2016 jangsy7883

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

