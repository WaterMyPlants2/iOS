//
//  SignInViewController.swift
//  WMP34
//
//  Created by Kelson Hartle on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let userController = UserController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text,
        !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
             else {
                                
                showAlert(title: "Unable to Login", message: "Please try again.")
                return
        }
        userController.loginUser(username: username, password: password) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    //TODO: fetch plants from server to display in table view.
                    //self.userController.fetchPlantsFromServer
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "Login failed", message: "Please try again.")
                    self.usernameTextField.text = ""
                    self.passwordTextField.text = ""
                }
            }
        }
    }
    
    // MARK: - Helper methods
       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default))
           present(alert, animated: true, completion: nil)
       }
}
