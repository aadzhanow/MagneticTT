//
//  MainViewController.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

struct ScreenType {
    var icon: UIImage
    var title: String
}

final class MainViewController: BaseViewController {
    let viewModel = MainViewModel()
    
    private let backgroundImage = UIImageView()
    private let devicesImageView = UIImageView()
    private let currentWifiView = CurrentWifiView()
    private var menuCollectionView: UICollectionView!
    
    private let screens: [ScreenType] = [
        ScreenType(icon: Assets.Icon.camera, title: "InfraredTitle".localizedUI),
        ScreenType(icon: Assets.Icon.bluetooth, title: "bluetoothTitle".localizedUI),
        ScreenType(icon: Assets.Icon.magnet, title: "magneticTitle".localizedUI),
        ScreenType(icon: Assets.Icon.bulb, title: "antispyTitle".localizedUI)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViews()
        setupConstraints()
        setupButtonActions()
        currentWifiView.wiFiNameLabel.text = viewModel.currentWiFiName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        menuCollectionView.showsHorizontalScrollIndicator = false
        menuCollectionView.showsVerticalScrollIndicator = false
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(MenuButtonCell.self, forCellWithReuseIdentifier: "MenuButtonCellIdentifier")
        view.addSubview(menuCollectionView)
        menuCollectionView.backgroundColor = .clear
    }
    
    @objc private func scanNetworkButtonTapped(_ sender: UIButton) {
        guard DoubleTapPreventer.shared.beginAction() else { return }
        sender.animateButtonTap()
        print("Scan Current Network Button Tapped!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            let networkScanVC = NetworkScanViewController()
            networkScanVC.viewModel = self.viewModel
            self.navigationController?.pushViewController(networkScanVC, animated: true)
        }
    }
    
    private func configureCell(_ cell: MenuButtonCell, at indexPath: IndexPath) {
        let screen = screens[indexPath.row]
        cell.iconImageView.image = screen.icon
        cell.titleLabel.text = screen.title
    }
    
    private func handleCellTap(at indexPath: IndexPath) {
        let screen = screens[indexPath.row]
        print("Tapped on screen: \(screen.title)")
    }
}

// MARK: - Menu Collection View Setup

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuButtonCellIdentifier", for: indexPath) as? MenuButtonCell else {
            fatalError("Cannot dequeue ButtonCell")
        }
        
        configureCell(cell, at: indexPath)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.animateCellTap()
        }
        handleCellTap(at: indexPath)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 139, height: 139)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

// MARK: - Setup UI and Button Actions

extension MainViewController {
    private func setupViews() {
        backgroundImage.image = Assets.Image.mainBackground
        view.addSubview(backgroundImage)
        view.addSubview(navBar)
        devicesImageView.image = Assets.Image.devices
        view.addSubview(devicesImageView)
        view.addSubview(currentWifiView)
        view.addSubview(menuCollectionView)
        navBar.leftButton.isHidden = true
        navBar.rightButton.setImage(Assets.Icon.settings, for: .normal)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(42)
        }
        devicesImageView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalToSuperview().multipliedBy(0.1765)
        }
        currentWifiView.snp.makeConstraints { make in
            make.top.equalTo(devicesImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(198)
        }
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(currentWifiView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupButtonActions() {
        currentWifiView.scanNetworkButton.addTarget(self, action: #selector(scanNetworkButtonTapped), for: .touchUpInside)
    }
}
