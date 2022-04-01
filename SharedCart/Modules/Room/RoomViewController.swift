//
//  RoomViewController.swift
//  SharedCart
//
//  Created by Jeytery on 19.03.2022.
//

import UIKit
import SnapKit
import SwiftUI

class EntitySelector {
    
    private var entities: Entities
    
    init(entities: Entities) {
        self.entities = entities
    }
    
    private func entityIndex(by id: String) -> Int? {
        for i in 0 ..< entities.count {
            if entities[i].id == id { return i }
        }
        return nil
    }
    
    func addEntity(_ entity: Entity) {
        
    }
    
    func removeEntity(at index: Int) {
        
    }
}

class RoomViewController: UIViewController {
    
    // ui
    private let tableView = TableView()
    private let addProductButton = Button()
    private lazy var board = EntitiesBoardView(entities: entities)
    
    // const
    private let headerHeight: CGFloat = 200
    private let cellHeight: CGFloat = 80
    
    // state
    private var products: Products = []
    
    private lazy var entitiesCenter = EntitiesCenter(entities: entities)
    
    private var entities: Entities = [
        .init(name: "Jeytery", sum: 123, color: Colors.primary.codableColor),
        .init(name: "Andry", sum: 45, color: UIColor.red.codableColor),
        .init(name: "BloodRedTape", sum: 234, color: UIColor.cyan.codableColor)
    ]
    
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
        
        addProductButton.setActiveStyle(icon: Icons.plus, title: "Add product")
        
        addProductButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(60)
            $0.width.equalTo(190)
            $0.centerX.equalToSuperview()
        }
        
        addProductButton.didTap = {
            [unowned self] in 
            let addProductVC = AddProductViewController(product: nil, entities: entities)
            addProductVC.delegate = self
            navigationController?.pushViewController(addProductVC, animated: true)
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
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! TableCell<DetailedProductView>
        
        let product = products[indexPath.row]
        
        if let entity = entity(by: product.entityId) {
            cell.baseView.setData(product: product, enitity: entity)
        }
        
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
        return board
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return headerHeight
    }
}

extension RoomViewController: AddProductViewControllerDelegate {
    private func entityIndex(by id: String) -> Int? {
        for i in 0 ..< entities.count {
            if entities[i].id == id { return i }
        }
        return nil
    }
    
    private func entity(by id: String) -> Entity? {
        guard let index = entityIndex(by: id) else { return nil }
        return entities[index]
    }
    
    private func addPriceToEnitity(_ price: Double, entityId: String) {
        guard let index = entityIndex(by: entityId) else { return }
        entities[index].sum += price
    }
    
    func addProductViewController(_ viewController: AddProductViewController, didCreate product: Product) {
        navigationController?.popViewController(animated: true)
        products.append(product)
        
        addPriceToEnitity(product.price, entityId: product.entityId)
        board.addPrice(product.price, entityId: product.entityId)
        
        tableView.reloadData()
    }
}
