//
//  Base.swift
//  SharedCart
//
//  Created by Jeytery on 18.03.2022.
//

import Foundation

struct Product: Codable {
    let name: String
    let price: Double
    let userId: String
}
typealias Products = [Product]

struct User: Codable {
    let name: String
    var id: String
}
typealias Users = [User]

struct Room: Codable {
    let id: String
    let users: Users
    let date: Date
    var products: Products
}
typealias Rooms = [Room]
