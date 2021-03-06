//
//  JLBannerView.m
//  JLBannerView
//
//  Created by Jangsy7883 on 2017. 4. 13..
//  Copyright © 2017년 Studio. All rights reserved.
//

#import "JLBannerView.h"

@interface JLBannerCell : UICollectionViewCell

@property (nonatomic, strong) UIView *itemView;

@end

static NSString *BannerCellReuseIdentifier = @"bannerCell";

@interface JLBannerView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) NSUInteger realIndex;

@property (nonatomic, readonly) NSInteger itemCount;
@property (nonatomic,assign) CGFloat lastContentOffsetX;

@end

@implementation JLBannerView

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _lastContentOffsetX = FLT_MIN;
    _scrollInterval = 5;
    _shouldLoop = YES;
    _autoScrolling = NO;
    _visiblePageControl = YES;
    _currentIndex = NSNotFound;
    _realIndex = NSNotFound;
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //CollectionView
    if (self.collectionView.superview == nil) {
        self.collectionView.frame = self.bounds;
        [self addSubview:self.collectionView];
        [self reloadData];
    }
    else {
        if (!CGRectEqualToRect(self.collectionView.frame, self.bounds) ) {
            self.collectionView.frame = CGRectMake(0, 0, round(CGRectGetWidth(self.bounds)), round(CGRectGetHeight(self.bounds)));
            [self.collectionView reloadData];
            [self layoutContentOffset];
        }
    }
    
    //PageControl
    if (_visiblePageControl && self.pageControl.superview == nil) {
        [self addSubview:self.pageControl];
    }
    else if (!_visiblePageControl && self.pageControl.superview) {
        [self.pageControl removeFromSuperview];
    }
    
    if (self.pageControl.superview) {
        if ([self.dataSource respondsToSelector:@selector(frameForPageControlInBannerView:)]) {
            self.pageControl.frame = [self.dataSource frameForPageControlInBannerView:self];
        }
        else{
            self.pageControl.frame = CGRectMake(0,
                                                CGRectGetHeight(self.bounds)-30,
                                                CGRectGetWidth(self.bounds),
                                                30);
        }
    }
}

- (void)layoutContentOffset {
    if (_realIndex == NSNotFound) {
        _realIndex = (self.shouldLoop) ? 1 : 0;
    }
    
    [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.collectionView.bounds)*_realIndex, 0) animated:NO];
}

#pragma mark - reload

- (void)reloadData {
    if (self.collectionView.superview && self.itemCount > 0) {
        self.pageControl.numberOfPages = self.itemCount;
        
        self.collectionView.bounces = (self.itemCount > 1);
        [self.collectionView reloadData];
        
        if (self.itemCount > 1) {
            [self layoutContentOffset];
            
            if (_autoScrolling) {
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScrollBannerView) object:nil];
                [self performSelector:@selector(autoScrollBannerView) withObject:nil afterDelay:self.scrollInterval];
            }
        }
        [self scrollViewDidScroll:self.collectionView];
    }
}

#pragma mark - UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.itemCount > 0) {
        return self.shouldLoop ? self.itemCount + 2 : self.itemCount;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self indexAtIndexPath:indexPath];
    JLBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCellReuseIdentifier forIndexPath:indexPath];
    cell.contentView.clipsToBounds = YES;
    
    if ([self.dataSource respondsToSelector:@selector(bannerView:reusableItemView:forItemAtIndex:)]) {
        cell.itemView = [self.dataSource bannerView:self reusableItemView:cell.itemView forItemAtIndex:index];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self indexAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)]) {
        [self.delegate bannerView:self didSelectItemAtIndex:index];
    }
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = 0;
    if (self.shouldLoop && self.itemCount > 1) {
        if (FLT_MIN == _lastContentOffsetX) {
            _lastContentOffsetX = scrollView.contentOffset.x;
            return;
        }
        
        CGPoint contentOffset = scrollView.contentOffset;
        CGFloat pageWidth = CGRectGetWidth(scrollView.bounds);
        CGFloat offset = pageWidth * self.itemCount;
        if (contentOffset.x < pageWidth && _lastContentOffsetX > contentOffset.x) {
            _lastContentOffsetX = contentOffset.x + offset;
            scrollView.contentOffset = (CGPoint){_lastContentOffsetX, contentOffset.y};
        }
        else if (contentOffset.x > offset && _lastContentOffsetX < contentOffset.x) {
            _lastContentOffsetX = contentOffset.x - offset;
            scrollView.contentOffset = (CGPoint){_lastContentOffsetX, contentOffset.y};
        }
        else {
            _lastContentOffsetX = contentOffset.x;
        }
        
        //PAGE CONTROL
        _realIndex = lround(_lastContentOffsetX/pageWidth);
        
        index = MAX(0, lround(_lastContentOffsetX/pageWidth)-1);
    }
    else{
        CGPoint contentOffset = scrollView.contentOffset;
        CGFloat pageWidth = CGRectGetWidth(scrollView.bounds);
        
        _realIndex = lround(contentOffset.x/pageWidth);
        
        index = MAX(0, lround(contentOffset.x/pageWidth));
    }
    
    if (_currentIndex != index) {
        _currentIndex = index;
        self.pageControl.currentPage = index;
        
        if ([self.delegate respondsToSelector:@selector(bannerView:didScrollToIndex:)]) {
            [self.delegate bannerView:self didScrollToIndex:index];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScrollBannerView) object:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_autoScrolling && self.collectionView.visibleCells.count > 0) {
        [self performSelector:@selector(autoScrollBannerView) withObject:nil afterDelay:self.scrollInterval];
    }
}

#pragma mark - NSIndexPath

- (NSInteger)indexAtIndexPath:(NSIndexPath *)indexPath {
    if (self.shouldLoop && self.itemCount > 1) {
        NSInteger index = indexPath.row-1;
        if (index < 0) {
            return self.itemCount-1;
        }
        else if (index == self.itemCount) {
            return  0;
        }
        else{
            return index;
        }
    }
    return indexPath.row;
}

#pragma mark - auto scroll

- (void)autoScrollBannerView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:_cmd object:nil];
    if (self.itemCount > 1 && self.collectionView.visibleCells.count > 0) {
        //        CGFloat offestY = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds);
        CGFloat offestY = CGRectGetWidth(self.collectionView.bounds) * (_realIndex + 1);
        [self.collectionView setContentOffset:CGPointMake(offestY, 0) animated:YES];
        if (_autoScrolling) {
            [self performSelector:_cmd withObject:nil afterDelay:self.scrollInterval];
        }
    }
}

#pragma mark - setters

- (void)setShouldLoop:(BOOL)shouldLoop {
    if (_shouldLoop != shouldLoop) {
        _shouldLoop = shouldLoop;
        [self reloadData];
    }
}

- (void)setAutoScrolling:(BOOL)autoScrolling {
    if (_autoScrolling != autoScrolling) {
        _autoScrolling = autoScrolling;
        
        if (_autoScrolling && self.collectionView.visibleCells.count > 0) {
            [self performSelector:@selector(autoScrollBannerView) withObject:nil afterDelay:self.scrollInterval];
        }
        else{
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScrollBannerView) object:nil];
        }
    }
}

- (void)setScrollInterval:(CGFloat)scrollInterval {
    if (_scrollInterval != scrollInterval) {
        _scrollInterval = scrollInterval;
        
        if (_autoScrolling && self.collectionView.visibleCells.count > 0) {
            [self performSelector:@selector(autoScrollBannerView) withObject:nil afterDelay:self.scrollInterval];
        }
    }
}

- (void)setVisiblePageControl:(BOOL)visiblePageControl {
    if (_visiblePageControl != visiblePageControl) {
        _visiblePageControl = visiblePageControl;
        
        if (_visiblePageControl && self.pageControl.superview == nil) {
            [self addSubview:self.pageControl];
        }
        else if (!_visiblePageControl && self.pageControl.superview) {
            [self.pageControl removeFromSuperview];
        }
    }
}

#pragma mark - getters

- (NSInteger)itemCount {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInBannerView:)]) {
        return [self.dataSource numberOfItemsInBannerView:self];
    }
    return 0;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.footerReferenceSize = CGSizeZero;
        flowLayout.headerReferenceSize = CGSizeZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.clipsToBounds = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[JLBannerCell class] forCellWithReuseIdentifier:BannerCellReuseIdentifier];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.autoresizingMask = UIViewAutoresizingNone;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

@end

@implementation JLBannerCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.itemView.frame = self.contentView.bounds;
}

- (void)setItemView:(UIView *)itemView{
    if (![_itemView isEqual:itemView]) {
        
        [_itemView removeFromSuperview];
        _itemView = itemView;
        
        [self.contentView addSubview:_itemView];
        [self setNeedsLayout];
    }
}

@end

