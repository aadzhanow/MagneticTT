//
//  DeviceCell.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class DeviceCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customItemBG
        return view
    }()
    
    let statusIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Icon.wifiConnected
        return imageView
    }()
    
    var deviceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.text = "MacTick-a123"
        label.font = .customFont(font: .sfProText, style: .medium, size: .s17)
        return label
    }()
    
    var ipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customDarkBlue
        label.text = "192.168.1.1"
        label.font = .customFont(font: .sfProText, style: .medium, size: .s13)
        return label
    }()
    
    var labelsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let chevronRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Icon.chevronRight
        return imageView
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
        backgroundColor = .customDarkBlue
        addSubview(containerView)
        addSubview(statusIconImageView)
        labelsVStack.addArrangedSubview(deviceNameLabel)
        labelsVStack.addArrangedSubview(ipLabel)
        addSubview(labelsVStack)
        addSubview(chevronRightImageView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        statusIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        labelsVStack.snp.makeConstraints { make in
            make.leading.equalTo(statusIconImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        chevronRightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
