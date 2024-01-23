//
//  UserListController.swift
//  PersonData
//
//  Created by Dhritiman Saha on 13/12/23.
//

import UIKit

class UserListController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    
    private let userViewModel = UserViewModel()
    var userList: [Employees] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllUser()
    }
    
    func fetchAllUser() {
        guard let users = userViewModel.fetchAllUser() else {
            userList = []
            return
        }
        userList = users
        userTableView.reloadData()
    }
    
    @IBAction func addUserClicked(_ sender: Any) {
        if let userDetailsCon = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsController") as? UserDetailsController {
            userDetailsCon.modalPresentationStyle = .fullScreen
            self.present(userDetailsCon, animated: true)
        }
    }
    
    func deleteUser(_ user: Employees?) {
        guard let user = user else {
            return
        }
        userViewModel.deleteUser(user)
    }
}

extension UserListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell", for: indexPath) as! UserDataCell
        let user = userList[indexPath.row]
        cell.populateUserData(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = userList[indexPath.row]
        if let userDetailsCon = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsController") as? UserDetailsController {
            userDetailsCon.empProfile = selectedUser
            userDetailsCon.modalPresentationStyle = .fullScreen
            self.present(userDetailsCon, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userToBeDeleted = userList[indexPath.row]
            guard let userId = userToBeDeleted.id else {
                return
            }
            if userViewModel.checkIfUserExist(by: userId) {
                let userToBeDeleted = userList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                userViewModel.deleteUser(userToBeDeleted)
            }
        }
    }
}
