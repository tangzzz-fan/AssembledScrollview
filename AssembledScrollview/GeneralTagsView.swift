//
//  GeneralTagsView.swift
//  Smile
//
//  Created by Tango on 2022/11/5.
//  Copyright © 2022 Azir. All rights reserved.
//

import UIKit
import Anchorage
import ReactiveSwift

struct TagsSettings {
    var lineSpacing: CGFloat = 16
    var itemSpacing: CGFloat = 12
}

class GeneralTagsView: UIView {
    
    private var tagTitles: [String] = []
    public var viewModel: GeneralTagsViewModelType
    private let disposables = CompositeDisposable()
    
    var collectionView = GeneralSectionCollectionView(frame: .zero,
                                                      collectionViewLayout: UICollectionViewLeftFlowLayout())
    
    private var settings: TagsSettings
    
    init(settings: TagsSettings = TagsSettings(), _ viewModel: GeneralTagsViewModelType) {
        self.settings = settings
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
        observeViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(collectionView)
        
        // Style
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(GeneralTagsCollectionViewCell.self)
        
        // Layout
        collectionView.topAnchor == topAnchor
        collectionView.leftAnchor == leftAnchor
        collectionView.rightAnchor == rightAnchor
        collectionView.bottomAnchor == bottomAnchor
    }
    
    func observeViewModel() {
        disposables += viewModel.output.reloadSignal
            .observe(on: UIScheduler())
            .observeValues { [weak self] _ in
                guard let self = self else { return }
                self.tagTitles = self.viewModel.output.tagTitles
                self.collectionView.reloadData()
            }
    }
}

extension GeneralTagsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = prepareTagCell(for: collectionView, and: indexPath)
        return cell
    }
    
    private func prepareTagCell(for collectionView: UICollectionView,
                                and indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: GeneralTagsCollectionViewCell.self, for: indexPath)
        cell.setupTagView(tagTitle: tagTitles[indexPath.row])
        return cell
    }
}

extension GeneralTagsView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return GeneralTagsCollectionViewCell.caculatedSize(tagTitles[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return settings.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return settings.itemSpacing
    }
    
}

class UICollectionViewLeftFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for index in 0 ..< attributes.count where index != attributes.count - 1 {
            let curAttr = attributes[index]
            let nextAttr = attributes[index + 1]
            let spacing = nextAttr.frame.minX - curAttr.frame.maxX
            // cells in the same row
            if curAttr.frame.minY == nextAttr.frame.minY, spacing > minimumInteritemSpacing {
                var frame = nextAttr.frame
                let frameX = curAttr.frame.maxX + minimumInteritemSpacing
                frame = CGRect(x: frameX, y: frame.minY, width: frame.width, height: frame.height)
                nextAttr.frame = frame
            }
        }
        return attributes
    }
    
}
