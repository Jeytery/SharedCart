//
//  MenuViewController.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
  
    private var list: ListView!
    private let connectButton =  Button()
    private let createButton =   UIButton()
    private let settingsButton = Button()
    
    private let historyDisplayerVC = HistoryCardsDisplayerViewController()
    
    private let headerTitles: [String?] = [
        "Connect",
        "Create",
        "History",
        "Application Settings"
    ]
    
    private let footerTitles: [String?] = [
        "This is common text to test the footer and view how good is it looks when there are a lot of text",
        "This is text for create button for testing its good-look showing, i hope it will be good",
        "Store last 10 carts",
        "version 0.1"
    ]
    
    private let buttonSize: CGFloat = 60
    
    private lazy var contentHeights: [CGFloat] = [
        buttonSize,
        buttonSize,
        200,
        buttonSize
    ]
    
    private lazy var views = [
        connectButton,
        createButton,
        historyDisplayerVC.view!,
        settingsButton
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureVC()
        configureList()
        configureCreateButton()
        configureConnectButton()
        configureSettigsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


//MARK: - ui
extension MenuViewController {
    private func configureVC() {
        title = "SharedCart"
    }
    
    private func configureList() {
        list = ListView(views: views)
        view.addSubview(list)
        list.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        list.delegate = self
        list.listDataSource = self
        list.backgroundColor = .white
    }
    
    @objc func createButtonDidTap() {
        let alert = UIAlertController(title: "Enter room data", message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            $0.placeholder = "Enter your name"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default) {
            [unowned self] _ in
            let ownerName = alert.textFields?[0].text ?? "Unammed user"
            createRoomAlertAction(ownerName: ownerName)
        }
        
        alert.addAction(createAction)
        
        
        alert.addAction(UIAlertAction(title: "close", style: .cancel) { _ in })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureCreateButton() {
        createButton.setActiveStyle(icon: Icons.plus, title: "Create")
        createButton.addTarget(self, action: #selector(createButtonDidTap), for: .touchUpInside)
    }
    
    private func configureConnectButton() {
        connectButton.setActiveStyle(icon: Icons.connect, title: "Connect", imageSize: 30)
        
        connectButton.didTap = {
            print("connect")
        }
    }
    
    private func configureSettigsButton() {
        settingsButton.setActiveStyle(icon: Icons.settings, title: "Settings")
    }
}

extension MenuViewController: UITableViewDelegate, ListViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contentHeights[indexPath.section]
    }

    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }

    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? {
        return footerTitles[section]
    }

    func listView(_ listView: ListView, cellInsetsAt indexPath: IndexPath) -> UIEdgeInsets {
        if indexPath.section == 2 { return .init(top: 0, left: 0, bottom: 0, right: 0) }

        return .init(top: 5, left: 20, bottom: -5, right: 20)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
}

extension MenuViewController {
    private func showConnectAlert() {
        
    }
    
    private func showCreateRoomAlert() {
        let alert = UIAlertController(
            title: "Enter room data",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField {
            textField in
            textField.placeholder = "Enter your name"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default, handler: {
            [unowned self] _ in
            let ownerName = alert.textFields?[0].text ?? "Unammed user"
            createRoomAlertAction(ownerName: ownerName)
        })
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        alert.addAction(createAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    private func createRoomAlertAction(ownerName: String) {
        let roomVC = RoomViewController()
        let nc = NavigationController(rootViewController: roomVC)
        nc.navigationBar.prefersLargeTitles = true
        nc.modalPresentationStyle = .overFullScreen
        
        present(nc, animated: true, completion: nil)
    }
}
