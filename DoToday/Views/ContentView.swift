//
//  ContentView.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManager = RealmManager()
    @State private var showAddTaskView = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            TasksView()
                .environmentObject(realmManager)
            
            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView()
                .environmentObject(realmManager)
        }
        .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment:  .bottom)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.99))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
