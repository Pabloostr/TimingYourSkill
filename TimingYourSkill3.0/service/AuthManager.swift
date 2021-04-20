//
//  AuthManager.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 20.04.2021.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    let auth = Auth.auth()
    
    func login(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void ) {
        auth.signIn(withEmail: email, password: password) { (result , error) in
            if let error = error {
                completion(.failure(error ))
            }else {
                completion(.success(()))
            }
        }
    }
    
    func logout(completion: (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch(let error) {
            completion(.failure(error))
        } 
    }
    
    func isUserLoggedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
}
