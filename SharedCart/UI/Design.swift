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
    func _setActiveStyle(icon: UIImage, title: String, scale: CGFloat = 2.3) {
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
    
    
    func setActiveStyle(icon: UIImage, title: String, imageSize: CGFloat = 25) {
        let label = UILabel()
        let imageView = UIImageView()
            
        addSubview(label)
        addSubview(imageView)
    
        label.text = title
        label.textColor = Colors.primary
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(imageSize)
            $0.centerY.equalToSuperview()
        }
        
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints {
            $0.right.equalTo(label.snp.left).offset(-7)
            $0.width.height.equalTo(imageSize)
            $0.centerY.equalToSuperview()
        }
        
        tintColor = Colors.primary
        backgroundColor = Colors.lightGray
        layer.cornerRadius = DesignProperties.cornerRadius
    }
}

class DesignProperties {
    static let cornerRadius: CGFloat = 15
}

