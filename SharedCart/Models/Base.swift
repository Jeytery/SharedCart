//
//  Base.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import Foundation
import UIKit

struct Product: Codable {
    let name: String
    let price: Double
    let entityId: String
}
typealias Products = [Product]

struct Room: Codable {
    let id: String
    
    let date: Date
    
    let entities: Entities
    var products: Products
}
typealias Rooms = [Room]

struct Entity: Codable {
    let name: String
    var sum: Double
    let color: CodableColor
    var id: String = UUID().uuidString
}
typealias Entities = [Entity]
