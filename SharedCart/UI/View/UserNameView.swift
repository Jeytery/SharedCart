//
//  UserNameView.swift
//  SharedCart
//
//  Created by Jeytery on 19.03.2022.
//

import UIKit
import SnapKit

class UserNameView: UIView {
    
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func shortName(_ name: String) -> String {
        let _name = name.uppercased()
        let first = _name.first!
        let last = _name.last!
        
        let middle = _name.middle
        
        return String(first) + String(middle) + String(last)
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    func setUser(color: UIColor, name: String) {
        backgroundColor = color
        nameLabel.text = shortName(name)
        nameLabel.textColor = Luma.blackOrWhite(color)
    }
}

extension StringProtocol {
    var middle: SubSequence {
        if isEmpty { return "" }
        if count == 1 { return  self[startIndex...startIndex] }
        let middleIndex = index(startIndex, offsetBy: count / 2)
        let previous = index(before: middleIndex)
        return count % 2 == 0 ? self[previous...middleIndex] : self[middleIndex...middleIndex]
    }
}
