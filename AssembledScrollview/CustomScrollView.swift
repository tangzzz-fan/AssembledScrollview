//
//  CustomScrollView.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/13.
//

import UIKit

class CustomScrollView: UIScrollView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        super.touchesShouldCancel(in: view)
        return true
    }
}
