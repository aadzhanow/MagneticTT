//
//  SceneDelegate.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
