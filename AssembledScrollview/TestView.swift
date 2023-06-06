//
//  TestView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit
import Anchorage

class TestView: UIView {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "TestView"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .random
        addSubview(label)
        
        label.edgeAnchors == edgeAnchors + 8
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
