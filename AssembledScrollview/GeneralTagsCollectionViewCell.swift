//
//  GeneralTagsCollectionViewCell.swift
//  Smile
//
//  Created by Tango on 2022/11/5.
//  Copyright © 2022 Azir. All rights reserved.
//

import UIKit
import Anchorage

class GeneralTagsCollectionViewCell: UICollectionViewCell {
    var colorView = UIView()
    var tagLabel = UILabel()
    var backView = UIButton()
    
    struct Settings {
        static let backgroundColor = UIColor .lightGray
        static let placeholderColor = UIColor.lightGray.withAlphaComponent(0.2)
        static let fontSize: CGFloat = 12
        static let shadowAlpha: Float = 0.3
        static let shadowColor = UIColor.lightGray
        static let shadowYOffset: CGFloat = 2
        static let shadowBlur: CGFloat = 4
    }
    
    struct LayoutConstants {
        static let backViewWidthMargin: CGFloat = 22
        static let colorWidth: CGFloat = 3
        static let cornerRadio: CGFloat = 3
        static let leftMargin: CGFloat = 8
        static let tagHeight: CGFloat = 24
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        backView.addSubview(colorView)
        backView.addSubview(tagLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTagView(tagTitle: String) {
        tagLabel.text = tagTitle
        
        backView.backgroundColor = Settings.backgroundColor
        backView.layer.cornerRadius = LayoutConstants.cornerRadio
        
        colorView.layer.cornerRadius = LayoutConstants.cornerRadio
        colorView.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMinXMinYCorner.rawValue |
            CACornerMask.layerMinXMaxYCorner.rawValue)
        
        tagLabel.textAlignment = .center
        tagLabel.backgroundColor = Settings.backgroundColor
        
        // Layout
        backView.heightAnchor == heightAnchor
        backView.widthAnchor == tagLabel.widthAnchor + LayoutConstants.backViewWidthMargin
        backView.leftAnchor == leftAnchor
        
        colorView.heightAnchor == backView.heightAnchor
        colorView.widthAnchor == LayoutConstants.colorWidth
        colorView.leftAnchor == backView.leftAnchor
        
        tagLabel.heightAnchor == heightAnchor
        tagLabel.centerXAnchor == backView.centerXAnchor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    static func caculatedSize(_ tagTitle: String) -> CGSize {
        let tagWidth = tagTitle.boundingSize(with: .zero,
                                             font: UIFont.systemFont(ofSize: 14)).1
        let width = tagWidth.width + LayoutConstants.backViewWidthMargin

        return CGSize(width: width, height: LayoutConstants.tagHeight)
    }
}
