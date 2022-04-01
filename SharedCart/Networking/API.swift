//
//  API.swift
//  SharedCart
//
//  Created by Jeytery on 19.03.2022.
//

import FirebaseFirestore

typealias ResultCompletion<ReturType, ErrorType: Error> = (Result<ReturType, ErrorType>) -> Void
typealias VoidCompletion<ErrorType: Error> = (ErrorType?) -> Void

fileprivate let database = Firestore.firestore()

func getRoom(by id: String, completion: ResultCompletion<Room, Error>) {}

func createRoom(with owner: Entity?, completion: VoidCompletion<Error>) {
    //database.document(<#T##documentPath: String##String#>)
    let ref = database.document("example/example")
    ref.setData(["example": "jeytery"])
    
}

func removeRoom(with id: String) {}

func addProduct() {}
func removeProduct() {}

func addEntity() {}
func removeEntity() {}

func updateRoom() {}

