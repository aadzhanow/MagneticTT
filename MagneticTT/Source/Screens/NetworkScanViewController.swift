//
//  NetworkScanViewController.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit
import Lottie

final class NetworkScanViewController: UIViewController {
    var viewModel: MainViewModel!
    
    private let scanningWiFiLabel = TitleTwoLabel(text: "scanningNetTitle".localizedUI)
    private let wiFiNameLabel = TitleOneLabel(text: "WIFI_Name")
    private let stopButton = CustomButton(title: "stopTitle".localizedUI)
    private let deviceCountView = DeviceCountOneView()
    
    private var labelsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    private var animationView: LottieAnimationView = {
        let animView = LottieAnimationView(name: Animation.radar)
        animView.loopMode = .loop
        return animView
    }()
    
    private var percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.text = "0%"
        label.font = .customFont(font: .sfProText, style: .semiBold, size: .s17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupButtonActions()
        animationView.play()
        wiFiNameLabel.text = viewModel.currentWiFiName
        
        viewModel.onProgressUpdate = { [weak self] progressText in
            self?.percentLabel.text = progressText
        }
        
        viewModel.updateProgress(to: 100) {
            print("Network Scanning Completed!")
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            self.deviceCountView.devicesCountLabel.text = String(self.viewModel.deviceList.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.navigateToDeviceList()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func navigateToDeviceList() {
        let deviceListVC = DeviceListViewController()
        deviceListVC.viewModel = self.viewModel
        navigationController?.pushViewController(deviceListVC, animated: true)
    }
    
    @objc private func stopButtonTapped(_ sender: UIButton) {
        guard DoubleTapPreventer.shared.beginAction() else { return }
        sender.animateButtonTap()
        print("Stop Button Tapped!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        navigationController?.popViewController(animated: true)
    }
}

extension NetworkScanViewController {
    private func setupViews() {
        view.backgroundColor = .customBackground
        view.addSubview(animationView)
        view.addSubview(percentLabel)
        labelsVStack.addArrangedSubview(scanningWiFiLabel)
        labelsVStack.addArrangedSubview(wiFiNameLabel)
        view.addSubview(labelsVStack)
        view.addSubview(deviceCountView)
        view.addSubview(stopButton)
    }
    
    private func setupConstraints() {
        labelsVStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(74)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.4123)
        }
        percentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        deviceCountView.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        stopButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
    }
    
    private func setupButtonActions() {
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
}
