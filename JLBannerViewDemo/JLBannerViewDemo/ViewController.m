//
//  ViewController.m
//  JLBannerViewDemo
//
//  Created by Woody on 2017. 4. 13..
//  Copyright © 2017년 Studio. All rights reserved.
//

#import "ViewController.h"
#import "JLBannerView.h"

@interface ViewController () <JLBannerViewDataSource, JLBannerViewDelegate>

@property (nonatomic, weak) IBOutlet JLBannerView *bannerView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bannerView reloadData];
}

#pragma mark - JLBannerViewDataSource

- (NSInteger)numberOfItemsInBannerView:(JLBannerView *)bannerView {
    return 10;
}

- (UIView *)bannerView:(JLBannerView *)bannerView reusableItemView:(UIView *)reusableItemView forItemAtIndex:(NSInteger)index {
    
    UILabel *label = (UILabel *)reusableItemView;
    if (label == nil || ![label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:35 weight:UIFontWeightMedium];
    }
    
    label.text = [NSString stringWithFormat:@"%zd",index];
    return label;
}

//- (CGRect)frameForPageControlInBannerView:(JLBannerView *)bannerView {
//    return
//}

#pragma mark - JLBannerViewDelegate

- (void)bannerView:(JLBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"selected %zd",index);
}
- (void)bannerView:(JLBannerView *)bannerView didScrollToIndex:(NSInteger)index {
    NSLog(@"scroll %zd",index);
}

@end
