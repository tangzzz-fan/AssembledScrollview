//
//  AssembledScrollview.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit
import Anchorage

class AssembledScrollview: UIView {
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private var scrollContentViewHeightConstraint: NSLayoutConstraint?
    private var sectionViews: [UIView] = []
    
    init(sectionViews: [UIView]) {
        self.sectionViews = sectionViews
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
    }
    
    func setupViews() {
        setupViewHierarchy()
        setupViewStyle()
        setupViewLayout()
    }
    
    private func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
    }
    
    private func setupViewStyle() {
        backgroundColor = .white
        clipsToBounds = true
    }
    
    private func setupViewLayout() {
        scrollView.edgeAnchors == edgeAnchors
        scrollContentView.edgeAnchors == scrollView.edgeAnchors
        scrollContentViewHeightConstraint = scrollView.heightAnchor <= scrollContentView.heightAnchor
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false

        var mostTopView: UIView?
        for sectionView in sectionViews {
            scrollContentView.addSubview(sectionView)
            if let view = mostTopView {
                view.bottomAnchor == sectionView.topAnchor
            }
            sectionView.leftAnchor == scrollContentView.leftAnchor
            sectionView.trailingAnchor == scrollContentView.trailingAnchor
            sectionView.widthAnchor == scrollView.widthAnchor
            mostTopView = sectionView
        }
        
        if let firstView = sectionViews.first {
            firstView.topAnchor == scrollContentView.topAnchor
        }
        
        if let lastView = sectionViews.last {
            lastView.bottomAnchor <= scrollContentView.bottomAnchor
        }
        
        scrollView.scrollIndicatorInsets = .zero
        scrollContentViewHeightConstraint?.constant = scrollView.contentInset.bottom - 0.5
    }

}

extension AssembledScrollview: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
