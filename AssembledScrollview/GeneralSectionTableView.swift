//
//  GeneralSectionTableView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

public protocol GeneralSectionTableViewDelegate: AnyObject {
    func didChangeContentSize()
}

// Autoresizable table view used in company overview container views
public class GeneralSectionTableView: UITableView {
    public weak var layoutDelegate: GeneralSectionTableViewDelegate?
    
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
            
            visibleSectionHeaders.forEach { header in
                UIView.performWithoutAnimation {
                    header.layoutIfNeeded()
                }
            }
            
            visibleSectionFooters.forEach { footer in
                UIView.performWithoutAnimation {
                    footer.layoutIfNeeded()
                }
            }
            
            layoutDelegate?.didChangeContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    private var visibleSectionHeaders: [UITableViewHeaderFooterView] {
        var views = [UITableViewHeaderFooterView]()
        for sectionIndex in Set((indexPathsForVisibleRows ?? []).map { $0.section }) {
            if let sectionHeader = headerView(forSection: sectionIndex) {
                views.append(sectionHeader)
            }
        }

        return views
    }
    
    private var visibleSectionFooters: [UITableViewHeaderFooterView] {
        var views = [UITableViewHeaderFooterView]()
        for sectionIndex in Set((indexPathsForVisibleRows ?? []).map { $0.section }) {
            if let sectionHeader = footerView(forSection: sectionIndex) {
                views.append(sectionHeader)
            }
        }

        return views
    }
}

