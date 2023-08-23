//
//  TasksView.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("do")
                    .font(.custom("Arial Rounded MT Bold", size: 40))
                Text("today")
                    .font(.custom("Arial Rounded MT Bold", size: 40))
                    .foregroundColor(Color(red: 0.79, green: 0.16, blue: 0.48))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .shadow(radius: 5.0)

            if realmManager.tasks.count < 1 {
                Text("Tap the (+) button to start adding")
                    .font(.custom("Arial Rounded MT Bold", size: 15))
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            
            List {
                
                ForEach(realmManager.tasks, id: \.id) {
                    task in
                    if !task.isInvalidated {
                        TaskRow(task: task.title, completed: task.completed)
                            .frame(height: 45)
                            .contentShape(Rectangle())
                            .font(.custom("Arial Rounded MT Bold", size: 17))
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    realmManager.deleteTask(id: task.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .onTapGesture {
                                realmManager.updateTask(id: task.id, completed: !task.completed)
                            }
                    }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.95))
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}
