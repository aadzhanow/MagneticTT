//
//  File.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

enum CustomFonts: String {
    case sfProText = "SFProText"
    case sfProDisplay = "SFProDisplay"
}

enum CustomFontStyle: String {
    case regular = "-Regular"
    case semiBold = "-Semibold"
    case medium = "-Medium"
    case bold = "-Bold"
}

enum CustomFontSize: CGFloat {
    case s28
    case s20
    case s17
    case s15
    
    var size: CGFloat {
        switch self {
        case .s28:
            return 28.0
        case .s20:
            return 20.0
        case .s17:
            return 17.0
        case .s15:
            return 15.0
        }
    }
}

extension UIFont {
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: CustomFontSize,
        isScaled: Bool = true) -> UIFont {
        
        let fontName: String = font.rawValue + style.rawValue
        
        guard let font = UIFont(name: fontName, size: size.size) else {
            debugPrint("Font \(fontName) can't be loaded")
            return UIFont.systemFont(ofSize: size.size)
        }
        
        return isScaled ? UIFontMetrics.default.scaledFont(for: font) : font
    }
}
