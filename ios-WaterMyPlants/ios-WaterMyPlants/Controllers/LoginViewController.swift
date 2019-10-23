//
//  LoginViewController.swift
//  ios-WaterMyPlants
//
//  Created by Joe Thunder on 10/19/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var modeController: UISegmentedControl!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var delegate: Accounts?
    var modeControl: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func modeControllerValueChanged(_ sender: Any) {
        if modeController.selectedSegmentIndex == 0 {
            actionButton.setTitle("Log In", for: .normal)
            self.modeControl = 0
        } else if modeController.selectedSegmentIndex == 1 {
            actionButton.setTitle("Sign Up", for: .normal)
            self.modeControl = 1
        }
        
    }
    
    
    // TODO: - Log In Function
    func logIn() {
        guard let user = userTextField.text, let pass = passTextField.text else { return }
        if user.isEmpty || pass.isEmpty {
            print("Username or password is blank. Present an alert stating this needs to be filled out, whether you like it or not.")
        }
        delegate?.user = user
        delegate?.password = pass
        
    }
    
    // TODO: - sign Up Function
    func signUp() {
        guard let user = userTextField.text, let pass = passTextField.text else { return }
              if user.isEmpty || pass.isEmpty {
                  print("Username or password is blank. Present an alert stating this needs to be filled out, whether you like it or not.")
              }
        delegate?.user = user
        delegate?.password = pass

        
    }
    
    // MARK: - Pop off the stack to get back to tableview.
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        if modeControl == 0 {
            logIn()
        } else if modeControl == 1 {
            signUp()
        }
 
        navigationController?.popViewController(animated: true)
               dismiss(animated: true, completion: nil)
    }
    
    
    // TODO: - create Alert for errors.

}
