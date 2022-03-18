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
    private let createButton =   Button()
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
    
    private let contentHeights: [CGFloat] = [
        70,
        70,
        200,
        70
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
    
    private func configureCreateButton() {
        createButton.setActiveStyle(icon: Icons.plus, title: "Create", scale: 3.3)
        
        createButton.didTap = {
            print("create")
        }
    }
    
    private func configureConnectButton() {
        connectButton.setActiveStyle(icon: Icons.connect, title: "Connect")
        
        connectButton.didTap = {
            print("connect")
        }
    }
    
    private func configureSettigsButton() {
        settingsButton.setActiveStyle(icon: Icons.settings, title: "Settings", scale: 2.5)
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
