//
//  EntitesBoardView.swift
//  SharedCart
//
//  Created by Jeytery on 20.03.2022.
//

import UIKit
import SnapKit

class EntitesBoardView: UIView {
    
    private let collectionView = CollectionView()
    
    private var selectedIndex: Int?
    
    var didSelect: ((Int) -> Void)? = nil
    
    init() {
        super.init(frame: .zero)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func select(at index: Int) {
        selectedIndex = index
        collectionView.reloadData()
    }
}

extension EntitesBoardView {
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
    }
}

extension EntitesBoardView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! CollectionCell<DetailedEntityView>
        
        cell.baseView.setEntity(color: Colors.primary, user: User(name: "Jeytery", id: ""), products: [])
        cell.baseView.layer.borderColor = UIColor.red.cgColor
        
        if indexPath.row == selectedIndex {
            cell.baseView.layer.borderWidth = 3
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.row)
    }
}
