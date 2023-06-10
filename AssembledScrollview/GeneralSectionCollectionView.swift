//
//  GeneralSectionCollectionView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

class GeneralSectionCollectionView: UICollectionView {
    private let lineSpacing: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.contentSize.width,
                      height: self.contentSize.height)
    }
}

