//
//  CreditCardListController.swift
//  PersonData
//
//  Created by Dhritiman Saha on 27/12/23.
//

import UIKit

class CreditCardListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var creditCardList: [Cards] = []
    
    let creditCardDetailsVM = CreditCardDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        fetchCardList()
    }
    
    func fetchCardList() {
        creditCardList = creditCardDetailsVM.fetchAllCards() ?? []
        tableView.reloadData()
    }

    @IBAction func addCreditCard(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(identifier: "CreditCardDetailsController") as? CreditCardDetailsController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension CreditCardListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        creditCardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardCell", for: indexPath) as? CreditCardCell else {
            return UITableViewCell()
        }
        cell.loadCardDetails(creditCardDetails: creditCardList[indexPath.row])
        return cell
    }
}

extension CreditCardListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cardToBeDeleted = creditCardList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            creditCardDetailsVM.deleteSelectedCard(cardToBeDeleted)
        }
    }
}
