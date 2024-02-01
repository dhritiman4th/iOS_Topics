//
//  TripProvider.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 30/01/24.
//

import Foundation
import CoreData

class TripProvider {
    weak var fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate?
    
    init(with fetchedResultControllerDelegate: NSFetchedResultsControllerDelegate) {
        self.fetchedResultControllerDelegate = fetchedResultControllerDelegate
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<CDTrip> = {
        let fetchReq: NSFetchRequest<CDTrip> = CDTrip.fetchRequest()
        fetchReq.fetchBatchSize = 20
        fetchReq.sortDescriptors = [NSSortDescriptor(key: "region", ascending: false)]
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchReq, managedObjectContext: PersistentStorage.shared.context, sectionNameKeyPath: "region", cacheName: nil)
        fetchedResultController.delegate = fetchedResultControllerDelegate
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
        return fetchedResultController
    }()
}
