//
//  HistoryCardView.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit
import SnapKit

class HistoryCardView: UIView {
    
    let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.primary
        layer.cornerRadius = DesignProperties.cornerRadius
        
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


