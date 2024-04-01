//
//  MainViewModel.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

struct DeviceModel {
    var name: String
    var status: Bool
    var ip: String
}

import Foundation

final class MainViewModel {
    
    var deviceList: [DeviceModel] = [
        DeviceModel(name: "Network1", status: true, ip: "192.168.1.1"),
        DeviceModel(name: "Network2", status: true, ip: "192.168.1.2"),
        DeviceModel(name: "Network3", status: true, ip: "192.168.1.3"),
        DeviceModel(name: "Network4", status: true, ip: "192.168.1.4"),
        DeviceModel(name: "Network5", status: false, ip: "192.168.1.5"),
        DeviceModel(name: "Network6", status: true, ip: "192.168.1.6"),
        DeviceModel(name: "Network7", status: false, ip: "192.168.1.7"),
        DeviceModel(name: "Network8", status: true, ip: "192.168.1.8"),
        DeviceModel(name: "Network9", status: false, ip: "192.168.1.9"),
        DeviceModel(name: "Network10", status: true, ip: "192.168.1.10"),
        DeviceModel(name: "Network11", status: false, ip: "192.168.1.11"),
        DeviceModel(name: "Network12", status: true, ip: "192.168.1.12"),
        DeviceModel(name: "Network13", status: false, ip: "192.168.1.13"),
        DeviceModel(name: "Network14", status: true, ip: "192.168.1.14"),
        DeviceModel(name: "Network15", status: false, ip: "192.168.1.15"),
        DeviceModel(name: "Network16", status: true, ip: "192.168.1.16"),
        DeviceModel(name: "Network17", status: false, ip: "192.168.1.17"),
        DeviceModel(name: "Network18", status: true, ip: "192.168.1.18"),
        DeviceModel(name: "Network19", status: false, ip: "192.168.1.19"),
        DeviceModel(name: "Network20", status: true, ip: "192.168.1.20"),
        DeviceModel(name: "Network21", status: false, ip: "192.168.1.21"),
        DeviceModel(name: "Network22", status: true, ip: "192.168.1.22"),
        DeviceModel(name: "Network23", status: false, ip: "192.168.1.23"),
        DeviceModel(name: "Network24", status: true, ip: "192.168.1.24"),
        DeviceModel(name: "Network25", status: false, ip: "192.168.1.25")
    ]

    var currentWiFiName = "Home123"
    var onProgressUpdate: ((String) -> Void)?
    var completion: (() -> Void)?
    var shouldStopAnimation = false

    func animateCountLabel(to userCount: Int, completion: @escaping () -> Void) {
        let countStart: Int = max(userCount - 100, 0)
        let countEnd: Int = userCount
        self.completion = completion
        shouldStopAnimation = false

        DispatchQueue.global(qos: .default).async { [weak self] in
            for i in (countStart...countEnd) {
                if self?.shouldStopAnimation == true {
                    DispatchQueue.main.async {
                        self?.completion?()
                    }
                    break
                }
                usleep(20000)
                DispatchQueue.main.async { [weak self] in
                    self?.onProgressUpdate?("\(i)%")
                    if i == countEnd {
                        self?.completion?()
                    }
                }
            }
        }
    }
    
    func stopAnimation() {
        shouldStopAnimation = true
    }
}
