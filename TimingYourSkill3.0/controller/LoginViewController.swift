//
//  LoginViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 19.04.2021.
//

import UIKit

class LoginViewController: UIViewController, Animatable {
    
    weak var delegate: LoginVCDelegate?
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginWithPavloButtonTapped(_ sender: UIButton) {
        
        let email = "pavlo@gmail.com"
        let password = "12345678"
        authManager.login(withEmail: email, password: password) { [weak self] (result) in
            switch result {
            case .success:
                self?.delegate?.didLogin()
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription, duration: 3.0)
            }
        }
    }
}
