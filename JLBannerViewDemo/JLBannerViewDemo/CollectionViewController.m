//
//  CollectionViewController.m
//  JLBannerViewDemo
//
//  Created by Jangsy7883 on 2017. 4. 26..
//  Copyright © 2017년 Studio. All rights reserved.
//

#import "CollectionViewController.h"
#import "CastBannerCell.h"



@interface CollectionViewController () <JLBannerViewDelegate, JLBannerViewDataSource>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"BannerCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[CastBannerCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width,
                      collectionView.bounds.size.width*0.389);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CastBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    
    cell.bannerView.delegate = self;
    cell.bannerView.dataSource = self;
    cell.bannerView.autoScrolling = YES;

    return cell;
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
        label.textColor = [UIColor whiteColor];
    }
    
    label.text = [NSString stringWithFormat:@"%zd",index];
    return label;
}

#pragma mark - JLBannerViewDelegate

- (void)bannerView:(JLBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"selected %zd",index);
}
- (void)bannerView:(JLBannerView *)bannerView didScrollToIndex:(NSInteger)index {
//    NSLog(@"scroll %zd",index);
}

@end
