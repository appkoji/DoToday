//
//  TaskRow.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: completed ? "checkmark.circle" : "circle")
            Text(task)
                .strikethrough(completed)
            Spacer()
            Image(systemName: "ellipsis")
                .font(.custom("Arial Rounded MT Bold", size: 20))
        }
        .foregroundColor( completed ? .green : .black)
        }
        
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do laundry", completed: true)
    }
}
