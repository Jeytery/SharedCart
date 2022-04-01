//
//  EntitiesCenter.swift
//  SharedCart
//
//  Created by Jeytery on 26.03.2022.
//

class EntitiesCenter {
    
    private var entities: Entities
    
    init(entities: Entities = []) {
        self.entities = entities
    }
}

extension EntitiesCenter {
    func addPrice(_ price: Double, entityId: String) {
        
    }
    
    func entityIndex(by id: String) -> Int {
        return 0
    }
}
