//
//  CurrentWifiView.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class CurrentWifiView: UIView {
    private let currentWiFiLabel = TitleTwoLabel(text: "currentWiFiLabel".localizedUI)
    private let callToActionLabel = TitleThreeLabel(text: "callToActionLabel".localizedUI)
    let wiFiNameLabel = TitleOneLabel(text: "WIFI_Name")
    let scanNetworkButton = CustomButton(title: "scanNetworkTitle".localizedUI)
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customItemBG
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let firstContentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let secondContentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let generalContentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(containerView)
        firstContentVStack.addArrangedSubview(currentWiFiLabel)
        firstContentVStack.addArrangedSubview(wiFiNameLabel)
        generalContentVStack.addArrangedSubview(firstContentVStack)
        secondContentVStack.addArrangedSubview(callToActionLabel)
        secondContentVStack.addArrangedSubview(scanNetworkButton)
        generalContentVStack.addArrangedSubview(secondContentVStack)
        addSubview(generalContentVStack)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        generalContentVStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        scanNetworkButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
