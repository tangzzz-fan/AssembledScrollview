//
//  GeneralSectionView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit

protocol GeneralSectionViewModelProtocol: AnyObject {
    func sectionWillAppear()
}

extension GeneralSectionViewModelProtocol {
    func sectionWillAppear() {}
}

protocol GeneralSectionViewDelegate: AnyObject {
    func sectionViewNeedsLayout(animated: Bool)
}

extension GeneralSectionViewDelegate {
    func sectionViewNeedsLayout(animated: Bool) {}
}

protocol GeneralSectionView: UIView {
    var delegate: GeneralSectionViewDelegate? { get set }
    var sectionViewModel: GeneralSectionViewModelProtocol? { get }
}

extension GeneralSectionView {
    var delegate: GeneralSectionViewDelegate? { nil }
    var sectionViewModel: GeneralSectionViewModelProtocol? { nil }
}
