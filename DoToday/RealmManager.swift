//
//  RealmManager.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init() {
        openRealm()
        getTasks()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("error opening Realm: \(error)")
        }
    }
    
    
    func addTask(taskTitle:String, taskDetail: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": taskTitle, "detail": taskDetail, "completed": false] as [String : Any])
                    localRealm.add(newTask)
                    getTasks()
                    print("added new task to realm: \(newTask)")
                }
            } catch {
                print("Error adding task to Realm")
            }
        }
    }
    
    
    func getTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with id \(id)! Completed status \(completed)")
                }
                
            } catch {
                print("Error updated task \(id) to realm: \(error)")
            }
        }
    }
    
    
    func deleteTask(id: ObjectId) {
        
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with id \(id)")
                }
                
            } catch {
                print("Error deleting task \(id) fromt Realm: \(error)")
            }
        }
        
    }
    
}
