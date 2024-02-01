//
//  CountryDetailsViewController.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 30/01/24.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subregionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var visitYearTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    
    var selectedTrip: CDTrip? = nil
    let vwModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }
    
    func populateData() {
        countryNameLabel.text = selectedTrip?.name
        capitalNameLabel.text = selectedTrip?.capital
        regionLabel.text = selectedTrip?.region
        subregionLabel.text = selectedTrip?.subRegion
        populationLabel.text = String(describing: selectedTrip?.population)
    }
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        if let visitYear = visitYearTextField.text, !visitYear.isEmpty {
            selectedTrip?.yearOfTravel = 100
        }
        if let about = aboutTextView.text, !about.isEmpty {
            selectedTrip?.about = about
        }
        guard let selectedTrip = selectedTrip else {
            return
        }
        vwModel.updateCountryDetails(trip: selectedTrip)
        self.dismiss(animated: true)
    }
    
}
