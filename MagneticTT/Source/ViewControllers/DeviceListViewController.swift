//
//  DeviceListViewController.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class DeviceListViewController: UIViewController {
    var viewModel: MainViewModel!
    
    private let navBar = NavigationBarView()
    private let deviceCountView = DeviceCountTwoView()
    private var deviceListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViews()
        setupConstraints()
        setupButtonActions()
        navBar.titleLabel.text = "resultsTitle".localizedUI
        deviceCountView.devicesCountLabel.text = String(viewModel.deviceList.count)
        deviceCountView.wifiNameLabel.text = viewModel.currentWiFiName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        deviceListCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        deviceListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        deviceListCollectionView.showsHorizontalScrollIndicator = false
        deviceListCollectionView.showsVerticalScrollIndicator = false
        deviceListCollectionView.dataSource = self
        deviceListCollectionView.delegate = self
        deviceListCollectionView.register(DeviceCell.self, forCellWithReuseIdentifier: "DeviceCellIdentifier")
        deviceListCollectionView.register(SeparatorView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SeparatorView")
        view.addSubview(deviceListCollectionView)
        deviceListCollectionView.backgroundColor = .clear
    }
    
    @objc private func backButtonTapped() {
        guard DoubleTapPreventer.shared.beginAction() else { return }
        
        if let navigationController = navigationController {
            var navigationArray = navigationController.viewControllers

            if navigationArray.count > 2 {
                navigationArray.removeLast(2)
                if let newRootViewController = navigationArray.last {
                    navigationController.popToViewController(newRootViewController, animated: true)
                }
            } else {
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
    
    private func configureCell(_ cell: DeviceCell, at indexPath: IndexPath) {
        let device = viewModel.deviceList[indexPath.row]
        cell.deviceNameLabel.text = device.name
        cell.ipLabel.text = device.ip
        cell.statusIconImageView.image = device.status ? Assets.Icon.wifiConnected : Assets.Icon.wifiError
    }
    
    private func handleCellTap(at indexPath: IndexPath) {
    }
}

// MARK: - Device List Collection View Setup

extension DeviceListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.deviceList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceCellIdentifier", for: indexPath) as? DeviceCell else {
            fatalError("Cannot dequeue ButtonCell")
        }
        
        configureCell(cell, at: indexPath)
        
        cell.layer.cornerRadius = 8
        cell.layer.mask = nil
        
        var corners: UIRectCorner = []
        
        if indexPath.section == 0 {
            corners.formUnion([.topLeft, .topRight])
        }
        if indexPath.section == collectionView.numberOfSections - 1 {
            corners.formUnion([.bottomLeft, .bottomRight])
        }

        if !corners.isEmpty {
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 8, height: 8))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            cell.layer.mask = mask
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        
        let separatorView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SeparatorView", for: indexPath) as! SeparatorView
        return separatorView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == collectionView.numberOfSections - 1 {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 1)
        }
    }
}

extension DeviceListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.animateCellTap()
        }
        handleCellTap(at: indexPath)
    }
}

extension DeviceListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 54
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - Setup UI and Button Actions

extension DeviceListViewController {
    private func setupViews() {
        view.backgroundColor = .customBackground
        view.addSubview(navBar)
        view.addSubview(deviceCountView)
    }
    
    private func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(42)
        }
        deviceCountView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        deviceListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(deviceCountView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupButtonActions() {
        navBar.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}
