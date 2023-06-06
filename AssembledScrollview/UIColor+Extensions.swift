//
//  UIColor+Extensions.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit

public extension UIColor {

    convenience init(hex: UInt64) {
        // swiftlint:disable identifier_name
        let r, g, b, a: CGFloat
        r = CGFloat((hex & 0xff000000) >> 24) / 255
        g = CGFloat((hex & 0x00ff0000) >> 16) / 255
        b = CGFloat((hex & 0x0000ff00) >> 8) / 255
        a = CGFloat(hex & 0x000000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }

    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

