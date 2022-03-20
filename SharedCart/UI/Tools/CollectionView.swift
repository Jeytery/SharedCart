//
//  CollectionView.swift
//  SharedCart
//
//  Created by Jeytery on 20.03.2022.
//

import UIKit

class CollectionView: UICollectionView {
    
    init(frame: CGRect = .zero) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
