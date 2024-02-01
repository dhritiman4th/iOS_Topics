//
//  PersistentStorage.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 25/01/24.
//

import Foundation
import CoreData

class PersistentStorage {
    static let shared = PersistentStorage()
    private init(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("DOCUMET DIR : \(String(describing: urls.first?.absoluteString))")
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TravelDiaryModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Persistent Storage Error : \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError("Persistent Storage saveContext error : \(error.localizedDescription)")
        }
    }
}
