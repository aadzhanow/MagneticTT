//
//  BaseViewController.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    let navBar = NavigationBarView()
    
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
    
    @objc func leftButtonTapped() {
        guard DoubleTapPreventer.shared.beginAction() else { return }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightButtonTapped() {
        guard DoubleTapPreventer.shared.beginAction() else { return }
    }
}

extension BaseViewController {
    private func setupViews() {
        view.backgroundColor = .customBackground
        view.addSubview(navBar)
    }
    
    private func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(42)
        }
    }
    
    private func setupButtonActions() {
        navBar.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        navBar.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
}
