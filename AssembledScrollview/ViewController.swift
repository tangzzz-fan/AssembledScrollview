//
//  ViewController.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit
import Anchorage

class ViewController: UIViewController {

    var assemblyScrollView: AssembledScrollview!
    
    lazy var sectionViews = {
        var views = [UIView]()
        for i in 0..<20 {
            let view = UIView()
            view.backgroundColor = .random
            view.heightAnchor == 200
            view.widthAnchor == UIScreen.main.bounds.width
            views.append(view)
        }
        return views
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assemblyScrollView = AssembledScrollview(sectionViews: sectionViews)
        assemblyScrollView.backgroundColor = .systemPink
        configureLayout()
    }

    func configureLayout() {
        view.addSubview(assemblyScrollView)
        assemblyScrollView.edgeAnchors == view.edgeAnchors
    }
}

