//
//  DeviceCountTwoView.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit
import SnapKit

final class DeviceCountTwoView: UIView {
    let wifiNameLabel = TitleThreeLabel(text: "WIFI_NAME")
    let devicesCountLabel = TitleOneLabel(text: "5")
    let devicesLabel = TitleOneLabel(text: "Devices")
    
    var labelsHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var labelsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
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
        labelsHStack.addArrangedSubview(devicesCountLabel)
        labelsHStack.addArrangedSubview(devicesLabel)
        labelsVStack.addArrangedSubview(labelsHStack)
        labelsVStack.addArrangedSubview(wifiNameLabel)
        addSubview(labelsVStack)
        devicesLabel.textColor = .customWhite
    }
    
    private func setupConstraints() {
        labelsVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
