//
//  DetailedProductView.swift
//  SharedCart
//
//  Created by Jeytery on 19.03.2022.
//

import UIKit

class DetailedProductView: UIView {
    
    private let userNameView = UserNameView()
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configurePriceLabel()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailedProductView {
    private func configureStackView() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
        }
        
        stackView.spacing = 10
        stackView.addArrangedSubview(userNameView)
        stackView.addArrangedSubview(nameLabel)
       
        userNameView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(25)
        }
        
        userNameView.layer.cornerRadius = 4
        nameLabel.font = .systemFont(ofSize: 19, weight: .medium)
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
        }
        priceLabel.font = .systemFont(ofSize: 19, weight: .medium)
    }
    
    func setProduct(name: String, price: String) {
        nameLabel.text = name
        priceLabel.text = price
        
        userNameView.setUser(color: Colors.primary, name: "Jeytery")
    }
    
    func setData(product: Product, enitity: Entity) {
        nameLabel.text = product.name
        priceLabel.text = String(product.price) + " UAH"
        
        userNameView.setUser(color: enitity.color.uiColor, name: enitity.name)
    }
}
