//
//  ViewController.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension ViewController {
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupButtonActions() {
        
    }
}
