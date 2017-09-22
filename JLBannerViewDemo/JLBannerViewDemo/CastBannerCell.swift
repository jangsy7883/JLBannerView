//
//  CastBannerCell.swift
//  JLBannerViewDemo
//
//  Created by Woody on 2017. 5. 25..
//  Copyright © 2017년 Woody. All rights reserved.
//

import UIKit

class CastBannerCell: UICollectionViewCell {
    var _bannerView: JLBannerView? = nil
    var bannerView: JLBannerView? {
        if _bannerView == nil {
            _bannerView = JLBannerView()
        }
        return _bannerView
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        bannerView?.frame = bounds
        if bannerView?.superview == nil {
            addSubview(bannerView!)
            bannerView?.reloadData()
        }
    }
}
