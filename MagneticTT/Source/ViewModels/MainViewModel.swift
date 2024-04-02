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
        DeviceModel(name: "Router", status: true, ip: "192.168.1.1"),
        DeviceModel(name: "Smart TV", status: true, ip: "192.168.1.2"),
        DeviceModel(name: "Home Security Camera", status: true, ip: "192.168.1.3"),
        DeviceModel(name: "Smart Thermostat", status: true, ip: "192.168.1.4"),
        DeviceModel(name: "Gaming Console", status: false, ip: "192.168.1.5"),
        DeviceModel(name: "Smart Light", status: true, ip: "192.168.1.6"),
        DeviceModel(name: "Wireless Speaker", status: false, ip: "192.168.1.7"),
        DeviceModel(name: "Smartphone", status: true, ip: "192.168.1.8"),
        DeviceModel(name: "Tablet", status: false, ip: "192.168.1.9"),
        DeviceModel(name: "Laptop", status: true, ip: "192.168.1.10"),
        DeviceModel(name: "Desktop PC", status: false, ip: "192.168.1.11"),
        DeviceModel(name: "Smart Watch", status: true, ip: "192.168.1.12"),
        DeviceModel(name: "Smart Fridge", status: false, ip: "192.168.1.13"),
        DeviceModel(name: "Wi-Fi Extender", status: true, ip: "192.168.1.14"),
        DeviceModel(name: "Printer", status: false, ip: "192.168.1.15"),
        DeviceModel(name: "NAS Storage", status: true, ip: "192.168.1.16"),
        DeviceModel(name: "Security System", status: false, ip: "192.168.1.17"),
        DeviceModel(name: "Smart Door Lock", status: true, ip: "192.168.1.18"),
        DeviceModel(name: "Voice Assistant", status: false, ip: "192.168.1.19"),
        DeviceModel(name: "Smart Oven", status: true, ip: "192.168.1.20"),
        DeviceModel(name: "DVR", status: false, ip: "192.168.1.21"),
        DeviceModel(name: "Smart Mirror", status: true, ip: "192.168.1.22"),
        DeviceModel(name: "Fitness Equipment", status: false, ip: "192.168.1.23"),
        DeviceModel(name: "Smart Vacuum", status: true, ip: "192.168.1.24"),
        DeviceModel(name: "Baby Monitor", status: false, ip: "192.168.1.25")
    ]

    var currentWiFiName = "Home123"
    var onProgressUpdate: ((String) -> Void)?
    var completion: (() -> Void)?
    var shouldStopAnimation = false

    func updateProgress(to userCount: Int, completion: @escaping () -> Void) {
        let countStart: Int = max(userCount - 100, 0)
        let countEnd: Int = userCount
        self.completion = completion
        shouldStopAnimation = false

        DispatchQueue.global(qos: .default).async { [weak self] in
            for i in (countStart...countEnd) {
                guard let self = self else { return }
                
                if self.shouldStopAnimation {
                    break
                }
                
                usleep(20000)
                
                DispatchQueue.main.async {
                    self.onProgressUpdate?("\(i)%")
                    if i == countEnd {
                        completion()
                    }
                }
            }
        }
    }
    
    func stopProgressUpdate() {
        shouldStopAnimation = true
    }
}
