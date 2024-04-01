//
//  SeparatorView.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit

class SeparatorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .customDarkBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
