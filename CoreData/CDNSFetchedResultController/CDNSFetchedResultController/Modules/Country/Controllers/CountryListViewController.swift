//
//  CountryListViewController.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 26/01/24.
//

import UIKit
import CoreData

class CountryListViewController: UIViewController {
    @IBOutlet weak var countryTableVw: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let countryVwModel = CountryViewModel()
    lazy var dataProvider: TripProvider = {
        let provider = TripProvider(with: self)
        return provider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountriesFromLocal()
    }

    @IBAction func optionButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "CDNSFetchedResultController Sample", 
                                      message: "Select any option",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Fetch from api and store into local storage", style: .default, handler: { _ in
            self.fetchCountryList()
        }))
        alert.addAction(UIAlertAction.init(title: "Load countries from local storage", style: .default, handler: { _ in
            self.loadCountriesFromLocal()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }

    func fetchCountryList() {
        activityIndicator.startAnimating()
        countryVwModel.fetchAllCountry { countries, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            if let err = error {
                print("ERROR -> \(String(describing: err.localizedDescription))")
            }
            self.saveToLocalStorage(countries: countries)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "App", message: "Saving done!!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive))
                self.present(alert, animated: true)
            }
        }
    }
    
    func saveToLocalStorage(countries: [CountryModel]) {
        countryVwModel.storeCountryLocally(countries: countries)
    }
    
    func loadCountriesFromLocal() {
        DispatchQueue.main.async {
            self.countryTableVw.reloadData()
        }
    }
}


extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let con = self.storyboard?.instantiateViewController(identifier: "CountryDetailsViewController") as? CountryDetailsViewController else {
            return
        }
        con.selectedTrip = dataProvider.fetchedResultController.object(at: indexPath)
        self.present(con, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryHeaderCell") as? CountryHeaderCell else {
            return UITableViewCell()
        }
        guard let sectionInfo = dataProvider.fetchedResultController.sections?[section] else {
            return UITableViewCell()
        }
        cell.regionLabel.text = sectionInfo.name
        return cell
    }
}

extension CountryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.fetchedResultController.sections?.count ?? 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = dataProvider.fetchedResultController.sections?[section] else {
            return nil
        }
        return sectionInfo.name
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = dataProvider.fetchedResultController.sections?[section]
        return sec?.numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell else {
            return UITableViewCell()
        }
        let sec = dataProvider.fetchedResultController.sections?[indexPath.section]
        guard let trip = sec?.objects?[indexPath.row] as? CDTrip else {
            return cell
        }
        cell.loadDataIntoCell(trip: trip, and: indexPath.row)
        return cell
    }
}

extension CountryListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        countryTableVw.reloadData()
    }
}
