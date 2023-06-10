//
//  GeneralSectionCollectionView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

class GeneralSectionCollectionView: UICollectionView {
    
    override public var contentSize: CGSize {
        didSet {
            guard !contentSize.equalTo(oldValue) else {
                return
            }
            
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            
            visibleCells.forEach { cell in
                UIView.performWithoutAnimation {
                    cell.layoutIfNeeded()
                }
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width,
                      height: contentSize.height)
    }
}

