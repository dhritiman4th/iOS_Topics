//
//  UserDataCell.swift
//  PersonData
//
//  Created by Dhritiman Saha on 13/12/23.
//

import UIKit

class UserDataCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var cardCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateUserData(user: Employees) {
        nameLabel.text = user.name
        countryLabel.text = user.country
        sexLabel.text = user.sex
        powerLabel.text = user.department
        cardCountLabel.text = "Number of cards : \((user.employeeToCard ?? []).count)"
    }
}
