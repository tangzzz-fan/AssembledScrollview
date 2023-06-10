//
//  UICollectionView+Extensions.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

public extension UICollectionReusableView {
    
    static var defaultReuseIdentifier: String {
        return description()
    }
    
}

public extension UICollectionView {
    
    static let elementKindSupplementaryView = "UICollectionView_elementKindSupplementaryView"
    static let elementKindSectionBottonInset = "UICollectionView_elementKindSectionBottonInset"
    
    // MARK: - Register cells & views
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_ cellClasses: [T.Type]) {
        cellClasses.forEach { register($0) }
    }
    
    func register<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind elementKind: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: viewClass.defaultReuseIdentifier)
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerSupplementaryView($0) }
    }
    
    // swiftlint:disable:next line_length
    func registerSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind: String = UICollectionView.elementKindSupplementaryView) {
        register(viewClass,
                 forSupplementaryViewOfKind: forSupplementaryViewOfKind,
                 withReuseIdentifier: viewClass.defaultReuseIdentifier)
    }
    
    func registerHeaderView<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: viewClass.defaultReuseIdentifier)
    }
    
    func registerHeaderViews<T: UICollectionReusableView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerHeaderView($0) }
    }
    
    func registerFooterView<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: viewClass.defaultReuseIdentifier)
    }
    
    func registerFooterViews<T: UICollectionReusableView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerFooterView($0) }
    }
    
    // MARK: - Dequeue cells & views
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: cellType.defaultReuseIdentifier,
                                           for: indexPath) as? T
            else { fatalError("Can't dequeue cell of type: \(cellType)") }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String,
                                                                       viewType: T.Type,
                                                                       for indexPath: IndexPath) -> T {
        guard
            let view = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                        withReuseIdentifier: viewType.defaultReuseIdentifier,
                                                        for: indexPath) as? T
            else { fatalError("Can't dequeue view of type: \(viewType)") }
        return view
    }
    
    func dequeueReusableHeaderView<T: UICollectionReusableView>(ofType viewType: T.Type,
                                                                for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                viewType: viewType,
                                                for: indexPath)
    }
    
    func dequeueReusableFooterView<T: UICollectionReusableView>(ofType viewType: T.Type,
                                                                for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                viewType: viewType,
                                                for: indexPath)
    }
    
}
