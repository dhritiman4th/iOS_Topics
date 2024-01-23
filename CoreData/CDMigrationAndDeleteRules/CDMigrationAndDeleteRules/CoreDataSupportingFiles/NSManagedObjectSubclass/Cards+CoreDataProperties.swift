//
//  Cards+CoreDataProperties.swift
//  CDMigrationAndDeleteRules
//
//  Created by Dhritiman Saha on 23/01/24.
//
//

import Foundation
import CoreData


extension Cards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cards> {
        return NSFetchRequest<Cards>(entityName: "Cards")
    }

    @NSManaged public var cardNo: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var cardToEmployee: Employees?

}

extension Cards : Identifiable {

}
