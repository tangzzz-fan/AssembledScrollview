//
//  UITableView+Extensions.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

public extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return description()
    }
    
}

public extension UITableViewHeaderFooterView {
    
    static var defaultReuseIdentifier: String {
        return description()
    }
    
    var backgroundViewColor: UIColor? {
        get { backgroundView?.backgroundColor }
        set {
            if backgroundView == nil {
                backgroundView = UIView()
            }
            backgroundView?.backgroundColor = newValue
        }
    }
}

public extension UITableView {
    
    // MARK: - Register cells & views
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    func register<T: UITableViewCell>(_ cellClasses: [T.Type]) {
        cellClasses.forEach { register($0) }
    }

    func registerHeaderView<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: aClass.defaultReuseIdentifier)
    }

    func registerHeaderViews<T: UITableViewHeaderFooterView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerHeaderView($0) }
    }

    func registerFooterView<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: aClass.defaultReuseIdentifier)
    }

    func registerFooterViews<T: UITableViewHeaderFooterView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerFooterView($0) }
    }
    
    // MARK: - Dequeue cells & views
    
    func dequeueReusableCell<T: UITableViewCell>(ofType cellType: T.Type,
                                                 for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.defaultReuseIdentifier,
                                           for: indexPath) as? T
            else { fatalError("Can't dequeue cell of type: \(cellType)") }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(ofType viewType: T.Type) -> T {
        guard
            let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.defaultReuseIdentifier) as? T
            else { fatalError("Can't dequeue headerFooter of type: \(viewType)") }
        return view
    }
    
}

public extension UITableView {
    func setAndAutoLayoutTableHeaderView(_ headerView: UIView) {
        DispatchQueue.main.async {
            self.tableHeaderView = headerView
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            self.tableHeaderView = headerView
        }
    }
}


