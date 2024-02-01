//
//  CountryViewModel.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 26/01/24.
//

import Foundation

class CountryViewModel {
    private let httpClient = HttpClient()
    private let persistentStorage = PersistentStorage.shared

    func fetchAllCountry(completionHandler: @escaping ([CountryModel], Error?) -> Void) {
        let resource = Resource(url: Constants.countryListURL, method: .GET([]), model: [CountryModel].self)
        httpClient.loadRequestWith(resource: resource) { result, error in
           completionHandler(result ?? [], error)
        }
    }
    
    func storeCountryLocally(countries: [CountryModel]) {
        countries.forEach { country in
            let trip = CDTrip(context: persistentStorage.context)
            trip.id = UUID()
            trip.name = country.name.common
            trip.capital = country.capital?.first ?? "NA"
            trip.flag = country.flag
            trip.population = country.population
            trip.region = country.region
            trip.subRegion = country.subregion ?? "NA"
            print("TRIP (\(String(describing: trip.name)))------ \(trip)")
        }
        self.persistentStorage.saveContext()
    }
    
//    func fetchCountriesFromLocal() -> [CDTrip] {
//        let fetchRequest = CDTrip.fetchRequest()
//        var trips = [CDTrip]()
//        do {
//            let result = try persistentStorage.context.fetch(fetchRequest)
//            trips = result
//            return trips
//        } catch {
//            print("Error in fetching from local!!!")
//            return trips
//        }
//    }
    
    func updateCountryDetails(trip: CDTrip) {
        let fetchRequest = CDTrip.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trip.id! as CVarArg)
        do {
            let dataCount = try persistentStorage.context.count(for: fetchRequest)
            if dataCount > 0 {
                persistentStorage.saveContext()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
