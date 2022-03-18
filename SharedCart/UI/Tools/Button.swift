//
//  Button.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit

class Button: UIButton {
    
    var didTap: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapAction() {
        didTap?()
    }
}

