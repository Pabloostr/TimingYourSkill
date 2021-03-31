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
    
    func addTasksListener(forDoneTasks isDone: Bool, completion: @escaping (Result<[Task], Error>) -> Void) {

        listener = tasksCollection
            .whereField("isDone", isEqualTo: isDone  )
            .order(by: "createdAt", descending: true)
            .addSnapshotListener({ (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else{
                
                var tasks = [Task]()
                do{
                    tasks = try snapshot?.documents.compactMap({ /// коротша версія запису зберігання данних
                        return try $0.data(as: Task.self)
                    }) ?? []
                }catch (let error){
                    completion(.failure(error))
                }
                /// 1 спосіб як збергітаи данні
//                var tasks = [Task]()
//                snapshot?.documents.forEach({ (document) in
//                    if let task = try? document.data(as: Task.self){
//                        tasks.append(task)
//                    }
//                })
                completion(.success(tasks))
            }
        })
    }
    
    func updateTaskToDone(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let fields: [String: Any] = ["isDone": true, "doneAt": Date()]
        tasksCollection.document(id).updateData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(()))
            }
        }
    }

}
