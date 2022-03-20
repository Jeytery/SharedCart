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

    static let primary = Color(hex: "#4EE0B4")
    
    static let lightGray = Color(hex: "F5F5F5")
    
    static let background = UIColor.white
    
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
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
