//
//  DatabaseManager.swift
//  TimingYourSkill3.0
//
//  Created by Pavlo Ostrozhynskyi on 30.03.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManeger {
    
    private let db = Firestore.firestore()
    private lazy var tasksCollection = db.collection("tasks")
    
    
    
    
    func addTask(_ task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        
        do{
          _ = try tasksCollection.addDocument(from: task, completion: { (error) in
                if let error = error{
                    completion(.failure(error))
                }else  {
                    completion(.success(()))
                }
            })
        }catch(let error) {
            completion(.failure(error))
        }

    }
}
