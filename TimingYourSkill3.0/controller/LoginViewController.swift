//
//  LoginViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 19.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var delegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginWithPavloButtonTapped(_ sender: UIButton) {
        delegate?.didLogin()
    }
    
}
