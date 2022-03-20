//
//  RoomViewController.swift
//  SharedCart
//
//  Created by Jeytery on 19.03.2022.
//

import UIKit
import SnapKit

class RoomViewController: UIViewController {
    
    private let tableView = TableView()
    
    private let addProductButton = Button()
    
    private let headerHeight: CGFloat = 200
    private let cellHeight: CGFloat = 120
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Colors.background
        configureTableView()
        configureAddProductButton()
        
        title = "F#41FVQ"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RoomViewController {
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableCell<DetailedProductView>.self, forCellReuseIdentifier: "cell")
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: view.safeAreaInsets.bottom + 60 + 10, right: 0)
    }
    
    private func configureAddProductButton() {
        view.addSubview(addProductButton)
        
        addProductButton.setActiveStyle(icon: Icons.plus, title: "Add product", scale: 3)
        
        addProductButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(60)
            $0.width.equalTo(190)
            $0.centerX.equalToSuperview()
        }
        
        addProductButton.backgroundColor = .white
        
        addProductButton.layer.shadowRadius = 10
        addProductButton.layer.shadowOpacity = 0.1
        addProductButton.layer.shadowOffset = .init(width: 0, height: 1)
        addProductButton.layer.shadowColor = UIColor.black.cgColor
    }
}

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! TableCell<DetailedProductView>
        
        cell.baseView.setProduct(name: "Milk", price: "35 UAH")
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return EntitesBoardView()
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return headerHeight
    }
}
