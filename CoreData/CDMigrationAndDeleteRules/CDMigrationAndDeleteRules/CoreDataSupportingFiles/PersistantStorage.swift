//
//  PersistantStorage.swift
//  PersonData
//
//  Created by Dhritiman Saha on 12/12/23.
//

import Foundation
import CoreData

class PersistantStorage {
    private init() {
        let docDirUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("PATH = \(String(describing: docDirUrls.first))")
    }
    static let shared = PersistantStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmployeesDM")
        print(container.persistentStoreDescriptions)
        container.loadPersistentStores { storeDescription, error in
            if let err = error {
                fatalError("Unresolved error: \(err.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError("Saving error: \(error.localizedDescription)")
        }
    }
    
}
