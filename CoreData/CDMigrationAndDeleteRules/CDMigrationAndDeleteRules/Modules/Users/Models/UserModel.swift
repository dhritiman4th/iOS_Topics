//
//  UserModel.swift
//  PersonData
//
//  Created by Dhritiman Saha on 22/01/24.
//

import Foundation

struct EmployeeModel {
    let id: UUID
    let department: String
    let age: Int16
    let country: String
    let name: String
    let sex: String
    
    init(id: UUID, department: String, age: Int16, country: String, name: String, sex: String) {
        self.id = id
        self.department = department
        self.age = age
        self.country = country
        self.name = name
        self.sex = sex
    }
}
