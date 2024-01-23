//
//  CreditCardDetailsController.swift
//  PersonData
//
//  Created by Dhritiman Saha on 27/12/23.
//

import UIKit

class CreditCardDetailsController: UIViewController {
    @IBOutlet weak var cardNoTextField: UITextField!
    @IBOutlet weak var selectUserTextField: UITextField!
    @IBOutlet weak var cardTypeSegmentedControl: UISegmentedControl!
    let userPickerView = UIPickerView()
    
    let viewModel = CreditCardDetailsViewModel()
    let userVM = UserViewModel()
    private var selectedUser: Employees? = nil
    var userList: [Employees] = [] {
        didSet {
            userPickerView.reloadAllComponents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        fetchAllUser()
    }
    
    func initialConfig() {
        self.tabBarController?.tabBar.isHidden = true
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.barTintColor = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelPickerSelection))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerSelection))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        selectUserTextField.inputView = userPickerView
        selectUserTextField.inputAccessoryView = toolbar
        userPickerView.delegate = self
        userPickerView.dataSource = self
        
        viewModel.setCardType(0)
    }
    
    @objc func donePickerSelection() {
        guard userList.count > 0 else {
            return
        }
        if selectedUser == nil {
            selectedUser = userList.first
        }
        selectUserTextField.text = selectedUser?.name
        selectUserTextField.resignFirstResponder()
    }
    
    @objc func cancelPickerSelection() {
        self.selectedUser = nil
        selectUserTextField.resignFirstResponder()
    }
    
    func fetchAllUser() {
        guard let users = userVM.fetchAllUser() else {
            userList = []
            return
        }
        userList = users
    }
    
    @IBAction func createAndAssignCardAction(_ sender: Any) {
        guard let selectedUser = selectedUser else {
            return
        }
        let result: (Bool, String) = viewModel.validateDetails(cardNo: cardNoTextField.text ?? "",
                                                                  type: viewModel.getCardType(),
                                                               holderName: selectedUser.name)
        guard result.0 else {
            let alert = UIAlertController(title: "Person Data", message: result.1, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .destructive))
            self.present(alert, animated: true)
            return
        }
        
        viewModel.saveCreditCard(cardNo: cardNoTextField.text ?? "0",
                                 cardType: viewModel.getCardType(),
                                 user: selectedUser)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func selectDataType(_ sender: UISegmentedControl) {
        viewModel.setCardType(sender.selectedSegmentIndex)
        print(sender.selectedSegmentIndex)
    }
}

extension CreditCardDetailsController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        userList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        userList[row].name ?? ""
    }
    
}

extension CreditCardDetailsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = userList[row]
    }
}
