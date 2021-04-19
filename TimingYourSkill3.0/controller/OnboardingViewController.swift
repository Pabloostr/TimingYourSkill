//
//  OnboardingViewController.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 19.04.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLoginScreen", let destination = segue.destination as? LoginViewController {
            destination.delegate = self
        }
    }
    
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showLoginScreen", sender: nil )
    }
    
    
}

extension OnboardingViewController: LoginVCDelegate {
    func didLogin() {
        presentedViewController?.dismiss(animated: true, completion: {
            print("we should login and show the main app now")
        })
    }
    
    
    
}
