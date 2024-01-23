//
//  Employees+CoreDataProperties.swift
//  CDMigrationAndDeleteRules
//
//  Created by Dhritiman Saha on 23/01/24.
//
//

import Foundation
import CoreData


extension Employees {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employees> {
        return NSFetchRequest<Employees>(entityName: "Employees")
    }

    @NSManaged public var age: Int16
    @NSManaged public var country: String?
    @NSManaged public var department: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var sex: String?
    @NSManaged public var employeeToCard: NSSet?

}

// MARK: Generated accessors for employeeToCard
extension Employees {

    @objc(addEmployeeToCardObject:)
    @NSManaged public func addToEmployeeToCard(_ value: Cards)

    @objc(removeEmployeeToCardObject:)
    @NSManaged public func removeFromEmployeeToCard(_ value: Cards)

    @objc(addEmployeeToCard:)
    @NSManaged public func addToEmployeeToCard(_ values: NSSet)

    @objc(removeEmployeeToCard:)
    @NSManaged public func removeFromEmployeeToCard(_ values: NSSet)

}

extension Employees : Identifiable {

}
