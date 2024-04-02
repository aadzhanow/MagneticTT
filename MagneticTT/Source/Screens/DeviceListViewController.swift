//
//  DeviceListViewController.swift
//  MagneticTT
//
//  Created by Alisher on 31.03.2024.
//

import UIKit
import SnapKit

final class DeviceListViewController: BaseViewController {
    var viewModel: MainViewModel!
    
    private let deviceCountView = DeviceCountTwoView()
    
    private lazy var deviceListTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 54
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DeviceCell.self, forCellReuseIdentifier: String(describing: DeviceCell.self))
        tableView.cornerRadius = 12
        tableView.separatorColor = .customDarkBlue
        tableView.separatorInset = .zero
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomPopGesture()
        setupViews()
        setupConstraints()
        navBar.titleLabel.text = "resultsTitle".localizedUI
        deviceCountView.devicesCountLabel.text = String(viewModel.deviceList.count)
        deviceCountView.wifiNameLabel.text = viewModel.currentWiFiName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc override func leftButtonTapped() {
        guard DoubleTapPreventer.shared.beginAction() else { return }
        
        navigateToMainScreen()
    }
    
    @objc func handleCustomPopGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
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
    
    // MARK: - Table View Cell Setup
    
    private func configureCell(_ cell: DeviceCell, at indexPath: IndexPath) {
        let device = viewModel.deviceList[indexPath.row]
        cell.selectionStyle = .none
        cell.deviceNameLabel.text = device.name
        cell.ipLabel.text = device.ip
        cell.statusIconImageView.image = device.status ? Assets.Icon.wifiConnected : Assets.Icon.wifiError
    }
}

// MARK: - Setup UI and Button/Gesture Actions

extension DeviceListViewController {
    private func setupViews() {
        view.addSubview(deviceCountView)
        view.addSubview(deviceListTableView)
        deviceListTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupConstraints() {
        deviceCountView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        deviceListTableView.snp.makeConstraints { make in
            make.top.equalTo(deviceCountView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func addCustomPopGesture() {
        let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleCustomPopGesture(_:)))
        gestureRecognizer.edges = .left
        view.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - TableView Delegate, TableView Data Source

extension DeviceListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.deviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DeviceCell.self), for: indexPath) as? DeviceCell else {
            fatalError("Unable to dequeue DeviceCell")
        }
        
        if indexPath == tableView.lastCellIndexPath {
            // Push the separator line out of frame
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width + 1, bottom: 0, right: 0)
        } else {
            cell.separatorInset = .zero
        }
        
        configureCell(cell, at: indexPath)
        
        cell.contentView.layer.cornerRadius = 0
        cell.contentView.layer.mask = nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.clipsToBounds = true
        
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cell.bounds
        
        let cornerRadius: CGFloat = 12
        
        if isFirstCell {
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            maskLayer.path = path.cgPath
            cell.contentView.layer.mask = maskLayer
        }
        
        if isLastCell {
            let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            maskLayer.path = path.cgPath
            cell.contentView.layer.mask = maskLayer
        }
    }
}


// MARK: - TableView+CornerRadius

extension UITableView {
     public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}

// MARK: - TableView+lastCellIndexPath

extension UITableView {
    /// Calculates the last cell index path if available
    var lastCellIndexPath: IndexPath? {
        for section in (0..<self.numberOfSections).reversed() {
            let rows = numberOfRows(inSection: section)
            guard rows > 0 else { continue }
            return IndexPath(row: rows - 1, section: section)
        }
        return nil
    }
}
