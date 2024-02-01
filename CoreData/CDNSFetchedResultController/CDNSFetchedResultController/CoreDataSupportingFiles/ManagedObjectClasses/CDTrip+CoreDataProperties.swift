//
//  CDTrip+CoreDataProperties.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 27/01/24.
//
//

import Foundation
import CoreData


extension CDTrip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTrip> {
        return NSFetchRequest<CDTrip>(entityName: "CDTrip")
    }

    @NSManaged public var about: String?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var capital: String?
    @NSManaged public var flag: String?
    @NSManaged public var yearOfTravel: Int16
    @NSManaged public var region: String?
    @NSManaged public var subRegion: String?
    @NSManaged public var population: Int64

}

extension CDTrip : Identifiable {

}
