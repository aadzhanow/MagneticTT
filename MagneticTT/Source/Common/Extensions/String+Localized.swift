//
//  String+Localized.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import Foundation

extension String {
    var localizedUI: String {
        return NSLocalizedString(self, tableName: "UserInterface", bundle: .main, value: "", comment: "")
    }
}
