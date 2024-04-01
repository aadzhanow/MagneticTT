//
//  DeviceCountOneView.swift
//  MagneticTT
//
//  Created by Alisher on 01.04.2024.
//

import UIKit
import SnapKit

final class DeviceCountOneView: UIView {
    let devicesCountLabel = TitleOneLabel(text: "5")
    let devicesLabel = TitleOneLabel(text: "Devices Found...")
    
    var labelsHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
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
        addSubview(labelsHStack)
        devicesLabel.textColor = .customWhite
        devicesLabel.font = .customFont(font: .sfProText, style: .semiBold, size: .s17)
    }
    
    private func setupConstraints() {
        labelsHStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
