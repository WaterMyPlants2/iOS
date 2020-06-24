//
//  RegisterNewUserViewController.swift
//  WMP34
//
//  Created by Kelson Hartle on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class RegisterNewUserViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    
    let userController = UserController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        //usernameTextField.becomeFirstResponder()
    }
    
    @IBAction func registerNewUser(_ sender: UIButton) {
        guard let username = usernameTextField.text,
        !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let phonenumber = phonenumberTextField.text,
            !phonenumber.isEmpty else {
                                
                showAlert(title: "Unable to register!", message: "Please fill in all fields before moving on.")
                return
        }
        
        //TODO: Implement method for registering a new user.
        
        userController.registerUser(username: username, password: password, phonenumber: phonenumber) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowLoginVC", sender: nil)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "Unable to register!", message: "Unable to register, try again later.")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
