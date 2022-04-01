//
//  EntitesBoardView.swift
//  SharedCart
//
//  Created by Jeytery on 20.03.2022.
//

import UIKit
import SnapKit

class EntitiesBoardView: UIView {
    
    var didSelect: ((Int) -> Void)?
    
    private let selectedEntityBoardWidth: CGFloat = 4

    private let collectionView = CollectionView()
    
    // state
    private var selectedIndex: Int?
    private var selectedEntityPrice: Double?
    private(set) var selectedEntity: Entity?
    private var entities: Entities = []

    init(entities: Entities = []) {
        self.entities = entities
        super.init(frame: .zero)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

extension EntitiesBoardView {
    private func configureCollectionView() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        collectionView.layer.cornerRadius = 15
        
        collectionView.backgroundColor = .clear
        
        collectionView.delegate =   self
        collectionView.dataSource = self
        
        collectionView.register(CollectionCell<DetailedEntityView>.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension EntitiesBoardView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return entities.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! CollectionCell<DetailedEntityView>
        
        cell.baseView.setEntity(entities[indexPath.row])
        cell.baseView.layer.borderColor = Colors.primary.cgColor
        
        if indexPath.row == selectedIndex {
            cell.baseView.layer.borderWidth = selectedEntityBoardWidth
        }
        else {
            cell.baseView.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: 180, height: 180)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didSelect?(indexPath.row)
    }
}

//MARK: - public
extension EntitiesBoardView {
    func select(at index: Int) {
        if let _index = selectedIndex, let price = selectedEntityPrice {
            entities[_index].sum = price
        }
        
        selectedIndex = index
        selectedEntity = entities[index]
        selectedEntityPrice = entities[index].sum
        
        collectionView.reloadData()
    }
    
    func add(entity: Entity) {
        entities.append(entity)
        collectionView.reloadData()
    }
    
    func add(entities: Entities) {
        self.entities.append(contentsOf: entities)
        collectionView.reloadData()
    }
    
    func remove(entityAt index: Int) {
        entities.remove(at: index)
        collectionView.reloadData()
    }
    
    func setPriceForSelected(_ price: Double) {
        guard let selectedIndex = selectedIndex else { return }
        entities[selectedIndex].sum = price + (selectedEntityPrice ?? 0.0)
        collectionView.reloadData()
    }
 
    func addPrice(_ price: Double, entityId: String) {
        for i in 0 ..< entities.count {
            if entities[i].id == entityId { entities[i].sum += price }
        }
        collectionView.reloadData()
    }
    
    func minusPrice(_ price: Double, entityId: String) {
        for i in 0 ..< entities.count {
            if entities[i].id == entityId { entities[i].sum -= price }
        }
        collectionView.reloadData()
    }
}
