//
//  SettingsViewController.swift
//  waterMyPlantTemp
//
//  Created by Michael Flowers on 10/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var owner: Owner? {
        didSet {
            print("owner was set")
            updateViews()
        }
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        reEnterPasswordTextField.delegate = self
        updateViews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateOwner()
        reEnterPasswordTextField.text = ""
        return true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
       updateOwner()
    }
    
    private func updateViews(){
        guard let owner = owner, isViewLoaded else { return }
        usernameTextField.text = owner.username
        passwordTextField.text = owner.password
    }
    
    func alert(){
        let alert = UIAlertController(title: "Password Incorrect", message: "Please re-enter password to match", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func updateOwner(){
         guard let username =  usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty, let newPassword =  reEnterPasswordTextField.text, !newPassword.isEmpty else { return }
                guard password == newPassword  else {
                    alert()
                    return }
                if let owner =  owner {
                    OwnerController.shared.update(owner: owner, withNewUsername: username, withNewPassword: newPassword)
                } else {
        //            OwnerController.shared.createOwnerWith(username: username, email: <#T##String#>, password: <#T##String#>)
                }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

