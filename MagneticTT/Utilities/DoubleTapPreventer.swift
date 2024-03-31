//
//  DoubleTapPreventer.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

final class DoubleTapPreventer {
    static let shared = DoubleTapPreventer()

    private(set) var isButtonActionInProgress: Bool = false

    func beginAction() -> Bool {
        if isButtonActionInProgress { return false }
        isButtonActionInProgress = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { self.isButtonActionInProgress = false }
        return true
    }
}
