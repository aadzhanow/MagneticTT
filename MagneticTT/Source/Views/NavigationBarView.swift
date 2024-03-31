//
//  NavigationBarView.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class NavigationBarView: UIView {
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.Icon.chevronLeft, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(font: .sfProText, style: .semiBold, size: .s17)
        label.textColor = .customWhite
        return label
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
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(10)
            make.trailing.equalTo(rightButton.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
    }

}
