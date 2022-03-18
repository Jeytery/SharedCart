//
//  Icons.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit

class Icons {
    
    static func Icon(
        _ name: String,
        renderingMode: UIImage.RenderingMode = .alwaysTemplate
    ) -> UIImage {
        return UIImage(named: name)!.withRenderingMode(renderingMode)
    }
    
    static let connect = Icon("connect")
    static let plus = Icon("plus")
    static let settings = Icon("settings")
}
