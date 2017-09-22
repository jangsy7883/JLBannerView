//
//  CollectionViewController.swift
//  JLBannerViewDemo
//
//  Created by Woody on 2017. 5. 25..
//  Copyright © 2017년 Woody. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BannerCell"

class CollectionViewController: UICollectionViewController, JLBannerViewDelegate, JLBannerViewDataSource,UICollectionViewDelegateFlowLayout {

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(CastBannerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CastBannerCell
        cell.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        
        cell.bannerView?.delegate = self;
        cell.bannerView?.dataSource = self;
        cell.bannerView?.isAutoScrolling = true;
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width*0.389)
    }

    // MARK: - JLBannerViewDataSource
    
    func numberOfItems(in bannerView: JLBannerView!) -> Int {
        return 10;
    }
    
    func bannerView(_ bannerView: JLBannerView!, reusableItemView: UIView!, forItemAt index: Int) -> UIView! {
        var label: UILabel!
        if reusableItemView is UILabel {
            label = reusableItemView as! UILabel
        }
        else {
            label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 35, weight: UIFontWeightMedium)
            label.textColor = UIColor.white
        }
        
        label.text = String(index)
        return label
    }
    
    // MARK: - JLBannerViewDelegate
    
    func bannerView(_ bannerView: JLBannerView!, didScrollTo index: Int) {
        print("\(#function) \(index)")
    }
    
    func bannerView(_ bannerView: JLBannerView!, didSelectItemAt index: Int) {
        print("\(#function) \(index)")
    }
}
