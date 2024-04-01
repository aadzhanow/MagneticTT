//
//  TitleTwoLabel.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit

final class TitleTwoLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = .customWhite
        self.font = .customFont(font: .sfProText, style: .regular, size: .s15)
        self.textAlignment = .center
        self.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
