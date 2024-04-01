//
//  TitleOneLabel.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit

final class TitleOneLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = .customMain
        self.font = .customFont(font: .sfProText, style: .bold, size: .s28)
        self.textAlignment = .center
        self.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
