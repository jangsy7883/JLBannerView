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
    return self.items.count;
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

#pragma mark - item

- (NSArray *)items {
    return @[
             @"http://cfile1.uf.tistory.com/image/233AEA4F573C8328143E65",
             @"http://pds26.egloos.com/pds/201507/22/81/a0355381_55af0264b059e.jpg",
             @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQt-m6fw0m_JlRjr4_yPzRoexTSg_mAu2gNFei9yjAETDrhF4ieAA",
             @"http://www.smileformen.com/files/attach/images/383/428/189/e589099b8fad557f79db078a8dcae121.jpg",
             @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT4fhqazMqQ178V3SBgGJZEcwHGEYjzuwOUY-pquW0nloJ5rCyvvg",
             ];
}

@end
