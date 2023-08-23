//
//  Task.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey:  true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
    
    
    
}
