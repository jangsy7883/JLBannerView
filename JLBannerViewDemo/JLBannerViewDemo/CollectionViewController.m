//
//  CollectionViewController.m
//  JLBannerViewDemo
//
//  Created by Woody on 2017. 4. 26..
//  Copyright © 2017년 Studio. All rights reserved.
//

#import "CollectionViewController.h"
#import "CastBannerCell.h"



@interface CollectionViewController () <JLBannerViewDelegate, JLBannerViewDataSource>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.alwaysBounceVertical = YES;

    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[CastBannerCell class] forCellWithReuseIdentifier:@"BannerCell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    CastBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
    cell.bannerView.delegate = self;
    cell.bannerView.dataSource = self;

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
