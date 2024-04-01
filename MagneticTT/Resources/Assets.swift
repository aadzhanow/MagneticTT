//
//  Assets.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

enum Assets {
    
    enum Icon {
        static let settings = UIImage(named: "Settings")!
        static let chevronLeft = UIImage(named: "ChevronLeft")!
        static let chevronRight = UIImage(named: "ChevronRight")!
        static let camera = UIImage(named: "WebcamIcon")!
        static let bluetooth = UIImage(named: "BluetoothIcon")!
        static let magnet = UIImage(named: "MagnetIcon")!
        static let bulb = UIImage(named: "LightbulbIcon")!
        static let wifiConnected = UIImage(named: "WiFiConnected")!
        static let wifiError = UIImage(named: "WiFiError")!
    }
    
    enum Image {
        static let mainBackground = UIImage(named: "MainBackground")!
        static let devices = UIImage(named: "Devices")!
    }
}

struct Cell {
    static let card = "CardCellIdentifier"
}

struct Animation {
    static let radar = "Radar"
}
