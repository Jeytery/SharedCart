//
//  DetailedEntityView.swift
//  SharedCart
//
//  Created by Jeytery on 20.03.2022.
//

import UIKit

class DetailedEntityView: UIView {

    private let userNameView = UserNameView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: .zero)
        
        configureView()
        
        configureUserNameView()
        configureNameLabel()
        configureStackView()
        
        configurePriceLabel()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setEntity(_ entity: Entity) {
        priceLabel.text = String(entity.sum) + " UAH"
        
        nameLabel.text = entity.name
        userNameView.setUser(color: entity.color.uiColor, name: entity.name)
    }
}

extension DetailedEntityView {
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = DesignProperties.cornerRadius
    }
    
    private func configureUserNameView() {
        userNameView.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        userNameView.layer.cornerRadius = 5
    }
    
    private func configureNameLabel() {
        nameLabel.font = .systemFont(ofSize: 19, weight: .semibold)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(20)
        }
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(userNameView)
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.bottom.equalToSuperview().offset(-20)
        }
        priceLabel.textAlignment = .center
        priceLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
}

