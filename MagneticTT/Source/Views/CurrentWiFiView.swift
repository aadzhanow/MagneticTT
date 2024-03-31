//
//  CurrentWiFiView.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class CurrentWiFiView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customItemBG
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let currentWiFiLabel: UILabel = {
        let label = UILabel()
        label.text = "currentWiFiLabel".localizedUI
        label.textColor = .customWhite
        label.font = .customFont(font: .sfProText, style: .regular, size: .s15)
        label.textAlignment = .center
        return label
    }()
    
    let wiFiNameLabel: UILabel = {
        let label = UILabel()
        label.text = "WIFI_Name".localizedUI
        label.textColor = .customMain
        label.font = .customFont(font: .sfProText, style: .bold, size: .s28)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let callToActionLabel: UILabel = {
        let label = UILabel()
        label.text = "callToActionLabel".localizedUI
        label.textColor = .customDarkBlue
        label.font = .customFont(font: .sfProText, style: .regular, size: .s17)
        label.textAlignment = .center
        return label
    }()
    
    let scanNetworkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customMain
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitle("Scan current network".localizedUI, for: .normal)
        button.tintColor = .customWhite
        button.titleLabel?.font = .customFont(font: .sfProDisplay, style: .semiBold, size: .s20)
        return button
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
