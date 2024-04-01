//
//  CustomNavigationController.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func popViewController(animated: Bool) -> UIViewController? {
        if let deviceListVC = topViewController as? DeviceListViewController, viewControllers.count > 2 {
            let targetVCIndex = viewControllers.count - 3
            return popToViewController(viewControllers[targetVCIndex], animated: animated)?.last
        } else {
            return super.popViewController(animated: animated)
        }
    }
}
