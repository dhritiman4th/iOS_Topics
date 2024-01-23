//
//  UserDetailsController.swift
//  PersonData
//
//  Created by Dhritiman Saha on 13/12/23.
//

import UIKit

class UserDetailsController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var empProfile: Employees? = nil
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUserDetails()
    }

    func populateUserDetails() {
        guard let userDetails = empProfile else {
            addButton.setTitle("Add", for: .normal)
            return
        }
        userNameTextField.text = userDetails.name
        ageTextField.text = "\(userDetails.age)"
        countryTextField.text = userDetails.country
        sexTextField.text = userDetails.sex
        departmentTextField.text = userDetails.department
        addButton.setTitle("Update", for: .normal)
    }

    @IBAction func addBttonAction(_ sender: Any) {
        guard let userName = userNameTextField.text,
              let age = ageTextField.text,
              let country = countryTextField.text,
              let sex = sexTextField.text,
              let department = departmentTextField.text else {
            let alert = UIAlertController(title: appName, message: "Sorry!!! You have to fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            self.present(alert, animated: true)
            return
        }
        
        guard let empProfile = self.empProfile,
        let userProfileId = empProfile.id else {
            let userModel = EmployeeModel(id: UUID(),
                                      department: department,
                                      age: Int16(age) ?? 0,
                                      country: country,
                                      name: userName,
                                      sex: sex)
            userViewModel.createUser(empModel: userModel)
            self.dismiss(animated: true)
            return
        }
        let userModel = EmployeeModel(id: userProfileId,
                                  department: department,
                                  age: Int16(age) ?? 0,
                                  country: country,
                                  name: userName,
                                  sex: sex)
        userViewModel.updateUser(empProfile, updateModel: userModel)
        self.dismiss(animated: true)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
