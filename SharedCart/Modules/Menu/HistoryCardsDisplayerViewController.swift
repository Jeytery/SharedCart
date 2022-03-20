//
//  HistoryCardsDisplayerViewController.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit
import SnapKit

class HistoryCardsDisplayerViewController: UIViewController {
    
    private let collectionView = CollectionView()

    init() {
        super.init(nibName: nil, bundle: nil)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HistoryCardsDisplayerViewController {
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCell<HistoryCardView>.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension HistoryCardsDisplayerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
  
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! CollectionCell<HistoryCardView>
        
        cell.baseView.label.text = String(indexPath.row)
        cell.baseView.backgroundColor = Colors.primary
   
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: 300, height: 200)
    }
}
