//
//  CollectionViewCell.m
//  JLBannerViewDemo
//
//  Created by Jangsy7883 on 2017. 4. 26..
//  Copyright © 2017년 Studio. All rights reserved.
//

#import "CastBannerCell.h"

@implementation CastBannerCell

- (void)layoutSubviews {
    self.bannerView.frame = self.contentView.bounds;
    
    if (self.bannerView.superview == nil) {
        [self.contentView addSubview:self.bannerView];
        [self.bannerView reloadData];
    }
}

- (JLBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[JLBannerView alloc] init];
    }
    return _bannerView;
}
@end
