//
//  Colors.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import UIKit

class Colors {
    
    //MARK: - hardcoded app colors
    
    static let blue = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    static let primary = Color(hex: "#10e6a5")
    
}


//MARK: - colors infrastructure
extension Colors {
    static func Color(_ name: String) -> UIColor {
        guard #available(iOS 11.0, *) else { return Colors.blue }
        return UIColor(named: name)!
    }
    
    static func Color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static func Color(hex: String) -> UIColor {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    return UIColor(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        return .white
    }
}
