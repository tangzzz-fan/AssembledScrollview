//
//  String+Extensions.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/10.
//

import UIKit

extension String {
    
    func boundingSize(with size: CGSize,
                      font: UIFont,
                      lineBreakMode: NSLineBreakMode = .byWordWrapping,
                      lineSpace: CGFloat? = nil) -> (NSMutableAttributedString, CGSize) {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineSpace = lineSpace {
            paragraphStyle.lineSpacing = lineSpace
        }
        paragraphStyle.lineBreakMode = lineBreakMode
        let attriStr = NSMutableAttributedString(string: self)
        attriStr.addAttributes([NSAttributedString.Key.font: font, .paragraphStyle: paragraphStyle],
                               range: NSRange(location: 0,
                                              length: self.count))
        
        let contentSize = attriStr.boundingRect(with: size,
                                                options: .usesLineFragmentOrigin,
                                                context: nil).size
        return (attriStr, contentSize)
    }
    
    func calculateMaxLines(width: CGFloat,
                           font: UIFont,
                           lineSpace: CGFloat? = nil) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let textSize = self.boundingRect(with: maxSize,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font as Any],
                                         context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
    
    func calculateMaxHeight(width: CGFloat,
                            font: UIFont,
                            lineCount: CGFloat = 4,
                            lineHeight: CGFloat,
                            lineSpacing: CGFloat = 4) -> CGFloat {
        let charSize = font.lineHeight
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineSpacing = lineSpacing - (font.lineHeight - font.pointSize)
        let baselineOffset = (lineHeight - font.lineHeight) / 4
        
        let attrs = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                     NSAttributedString.Key.font: font,
                     NSAttributedString.Key.baselineOffset: baselineOffset]
        as [NSAttributedString.Key: Any]
        let attriStr = NSMutableAttributedString(string: self, attributes: attrs)
        
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let contentSize = attriStr.boundingRect(with: maxSize,
                                                options: .usesLineFragmentOrigin,
                                                context: nil).size
        let maxHeight = lineCount * charSize + lineSpacing * (lineCount - 1)
        return min(maxHeight, contentSize.height)
    }
    
    func calculateMaxHeightForLabel(width: CGFloat,
                                    font: UIFont,
                                    lineCount: Int = 4,
                                    lineHeight: CGFloat,
                                    lineSpacing: CGFloat = 4) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let baselineOffset = (lineHeight - font.lineHeight) / 4
        
        let attrs = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                     NSAttributedString.Key.font: font,
                     NSAttributedString.Key.baselineOffset: baselineOffset]
        as [NSAttributedString.Key: Any]
        let attriStr = NSMutableAttributedString(string: self, attributes: attrs)
        
        let label = UILabel(frame: .zero)
        label.numberOfLines = lineCount
        label.attributedText = attriStr
        let contentSize = label.sizeThatFits(CGSize(width: width,
                                                    height: .greatestFiniteMagnitude))
        return contentSize.height
    }
    
    func flag() -> String? {
        let base: UInt32 = 127397
        var result = ""
        for scalar in self.unicodeScalars {
            result.unicodeScalars.append(UnicodeScalar(base + scalar.value)!)
        }
        return String(result)
    }
    
    mutating func add(prefix: String) {
        self = prefix + self
    }
    
    func subString(with range: NSRange) -> String? {
        let str = NSString(string: self)
        guard range.location >= 0,
              range.length + range.location >= 0,
              range.length + range.location <= self.count else {
            return nil
        }
        return String(str.substring(with: range))
    }
    
    func findAppropriateFontSize(boxSize: CGSize, orinFont: UIFont) -> UIFont {
        guard boxSize.width > 0, boxSize.height > 0 else {
            return orinFont
        }
        var height = self.boundingSize(with: boxSize, font: orinFont).1.height
        var tempFont = orinFont
        var fontSize = orinFont.pointSize
        while height + fontSize > boxSize.height, fontSize > 1 {
            fontSize -= 1
            tempFont = UIFont(name: orinFont.fontName, size: fontSize) ?? orinFont
            height = self.boundingSize(with: boxSize, font: tempFont).1.height
        }
        return tempFont
    }
}

public extension Optional where Wrapped == String {
    func toDouble() -> Double {
        return Double(self ?? "0") ?? 0
    }
    
    var safeString: String { self ?? "" }
}

public extension Optional where Wrapped == Character {
    var safeCharacter: Character { self ?? Character(" ") }
}

