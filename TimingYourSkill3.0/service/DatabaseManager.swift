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
    private var listener: ListenerRegistration?
    
    
    
    
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
    
    func addTasksListener(completion: @escaping (Result<[Task], Error>) -> Void) {

        listener = tasksCollection.addSnapshotListener({ (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else{
                /// 1 спосіб як збергітаи данні
//                var tasks = [Task]()
//                snapshot?.documents.forEach({ (document) in
//                    if let task = try? document.data(as: Task.self){
//                        tasks.append(task)
//                    }
//                })
                let tempTasks = try? snapshot?.documents.compactMap({ /// коротша версія запису зберігання данних
                    return try $0.data(as: Task.self)
                })
                let tasks = tempTasks ?? []
                completion(.success(tasks))
            }
        })
    }
}
