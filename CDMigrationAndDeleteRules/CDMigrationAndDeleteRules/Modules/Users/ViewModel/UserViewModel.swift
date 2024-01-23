//
//  UserViewModel.swift
//  PersonData
//
//  Created by Dhritiman Saha on 19/01/24.
//

import Foundation

class UserViewModel {
    private let persistentStorage = PersistantStorage.shared
    
    func createUser(empModel: EmployeeModel) {
        let internationalUser = Employees(context: persistentStorage.context)
        internationalUser.id = UUID()
        internationalUser.name = empModel.name
        internationalUser.age = Int16(empModel.age)
        internationalUser.country = empModel.country
        internationalUser.sex = empModel.sex
        internationalUser.department = empModel.department
        persistentStorage.saveContext()
    }
    
    func updateUser(_ user: Employees, updateModel: EmployeeModel) {
        user.name = updateModel.name
        user.age = Int16(updateModel.age)
        user.country = updateModel.country
        user.sex = updateModel.sex
        user.department = updateModel.department
        persistentStorage.saveContext()
    }
    
    func fetchAllUser() -> [Employees]? {
        let fetchRequest = Employees.fetchRequest()
        do {
            let results = try persistentStorage.context.fetch(fetchRequest)
            return results
        } catch {
            print("Fetch error!!! \(error.localizedDescription)")
            return nil
        }
    }
    
//    func fetchAllNonCardHolder() -> [InternationalUser]? {
//        let fetchRequest = InternationalUser.fetchRequest()
//        let predicate = NSPredicate(format: "employeeToCard.@count == 0")
//        fetchRequest.predicate = predicate
//        do {
//            let result = try persistentStorage.context.fetch(fetchRequest)
//            return result
//        } catch {
//            print("fetchAllNonCardHolder() : "+error.localizedDescription)
//            return nil
//        }
//    }
    
    func deleteUser(_ user: Employees) {
        guard let userId = user.id else {
            return
        }
        if checkIfUserExist(by: userId) {
            persistentStorage.context.delete(user)
            persistentStorage.saveContext()
        }
    }
    
    func checkIfUserExist(by id: UUID) -> Bool {
        let fetchRequest = Employees.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try persistentStorage.context.fetch(fetchRequest)
            return result.count > 0
        } catch {
            print("ERROR in checking user : \(error.localizedDescription)")
            return false
        }
    }
}
