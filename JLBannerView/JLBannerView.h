//
//  JLBannerView.h
//  JLBannerView
//
//  Created by Woody on 2017. 4. 13..
//  Copyright © 2017년 Goodoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLBannerViewDataSource, JLBannerViewDelegate;

@interface JLBannerView : UIView

@property (nonatomic, assign, getter = isShouldLoop) IBInspectable BOOL shouldLoop; // default is YES
@property (nonatomic, assign, getter = isAutoScrolling) IBInspectable BOOL autoScrolling; // default is NO
@property (nonatomic, assign, getter = isVisiblePageControl) IBInspectable BOOL visiblePageControl; // default is YES
@property (nonatomic, assign) IBInspectable CGFloat scrollInterval; // default is 5

@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet id<JLBannerViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<JLBannerViewDelegate> delegate;

- (void)reloadData;

@end

@protocol JLBannerViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInBannerView:(JLBannerView *)bannerView;
- (UIView *)bannerView:(JLBannerView *)bannerView reusableItemView:(UIView *)reusableItemView forItemAtIndex:(NSInteger)index;

@optional
- (CGRect)frameForPageControlInBannerView:(JLBannerView *)bannerView;

@end

@protocol JLBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(JLBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;
- (void)bannerView:(JLBannerView *)bannerView didScrollToIndex:(NSInteger)index;

@end
