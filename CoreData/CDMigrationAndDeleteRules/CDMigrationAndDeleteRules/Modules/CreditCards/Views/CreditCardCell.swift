//
//  CreditCardCell.swift
//  PersonData
//
//  Created by Dhritiman Saha on 27/12/23.
//

import UIKit

class CreditCardCell: UITableViewCell {
    @IBOutlet weak var cardNoLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardHolderName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadCardDetails(creditCardDetails: Cards) {
        cardNoLabel.text = String(describing: creditCardDetails.cardNo)
        cardTypeLabel.text = creditCardDetails.type
        cardHolderName.text = creditCardDetails.cardToEmployee?.name
    }
}
