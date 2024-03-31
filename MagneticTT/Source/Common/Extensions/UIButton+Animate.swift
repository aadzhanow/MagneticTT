//
//  UIButton+Animate.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

extension UIButton {
    func animateButtonTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = .init(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) { self.transform = .identity }
        }
    }
}
