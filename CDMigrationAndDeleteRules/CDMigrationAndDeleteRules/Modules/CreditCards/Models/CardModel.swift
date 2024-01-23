//
//  CardModel.swift
//  PersonData
//
//  Created by Dhritiman Saha on 22/01/24.
//

import Foundation

struct CardModel {
    let id: UUID
    let number: Int64
    let type: String
    
    init(id: UUID, number: Int64, type: String) {
        self.id = id
        self.number = number
        self.type = type
    }
}
