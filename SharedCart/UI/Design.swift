//
//  Design.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit
import SnapKit


//MARK: - UIButton
extension UIButton {
    func setActiveStyle(icon: UIImage, title: String, scale: CGFloat = 2.3) {
        backgroundColor = Colors.lightGray
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        let label = UILabel()
        let imageView = UIImageView()
        
        label.text = title
        imageView.image = icon

        imageView.snp.makeConstraints {
            $0.height.equalTo(icon.size.height / scale)
            $0.width.equalTo(icon.size.width / scale)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        tintColor = Colors.primary
        label.textColor = Colors.primary
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        layer.cornerRadius = DesignProperties.cornerRadius
    }
}

class DesignProperties {
    static let cornerRadius: CGFloat = 15
}

