//
//  SettingsViewController.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var user: User? {
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
          updateUser()
          reEnterPasswordTextField.text = ""
          return true
      }
      
      @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
         updateUser()
      }
      
      private func updateViews(){
          guard let user = user, isViewLoaded else { return }
          usernameTextField.text = user.username
          passwordTextField.text = user.password
      }
      
      func alert(){
          let alert = UIAlertController(title: "Password Incorrect", message: "Please re-enter password to match", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "Ok", style: .cancel)
          alert.addAction(okAction)
          present(alert, animated: true)
      }
      func updateUser(){
           guard let username =  usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty, let newPassword =  reEnterPasswordTextField.text, !newPassword.isEmpty else { return }
                  guard password == newPassword  else {
                      alert()
                      return }
                  if let user = user {
                    UserController.shared.update(user: user, username: username, password: newPassword)
                  } else {
          //            OwnerController.shared.createOwnerWith(username: username, email: <#T##String#>, password: <#T##String#>)
                  }
          self.navigationController?.popToRootViewController(animated: true)
      }

}
