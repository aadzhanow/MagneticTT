//
//  CustomButton.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

final class CustomButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .customMain
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.setTitle(title, for: .normal)
        self.tintColor = .customWhite
        
        self.titleLabel?.font = .customFont(font: .sfProDisplay, style: .semiBold, size: .s20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
