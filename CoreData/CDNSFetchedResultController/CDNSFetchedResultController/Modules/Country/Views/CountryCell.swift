//
//  CountryCell.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 26/01/24.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subregionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var visitedOnDateLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadDataIntoCell(trip: CDTrip, and index: Int) {
        countryNameLabel.text = "\(index) - \(trip.name ?? "")"
        capitalNameLabel.text = trip.capital
        regionLabel.text = trip.region
        subregionLabel.text = trip.subRegion
        populationLabel.text = String(describing: "Population : \(trip.population)")
        flagLabel.text = trip.flag
        aboutLabel.text = trip.about ?? " "
    }

}
