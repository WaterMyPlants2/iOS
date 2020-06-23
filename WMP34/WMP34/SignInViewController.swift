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

    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //usernameTextField.becomeFirstResponder()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper methods
       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default))
           present(alert, animated: true, completion: nil)
       }
}
