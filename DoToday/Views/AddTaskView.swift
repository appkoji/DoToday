//
//  AddTaskView.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var priority = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(alignment:  .leading, spacing: 20) {
            
            HStack {
                // (+)add stack + icon on side of 'add' text
                Image(systemName: "plus.circle")
                    .font(.system(size: 30))
                    .bold()
                Text("add")
                    .font(.custom("Arial Rounded MT Bold", size: 30))
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            .foregroundColor(Color(red: 0.79, green: 0.16, blue: 0.48))
            
            HStack{
                Text("Add task you can finish today")
                    .font(.custom("Arial Rounded MT Bold", size: 15))
                Text("*")
                    .foregroundColor(.red)
                // * for required field
            }
            
            
            TextField("Task title", text: $title)
                .frame(height: 50)
                .textFieldStyle(.plain)
                .cornerRadius(16)
                .padding([.leading, .trailing], 10)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke( Color.gray))
            
            Text("Details of the task?")
                .font(.custom("Arial Rounded MT Bold", size: 15))
            
            MultilineTextView(text: $detail)
                .frame(height: 200)
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke( Color.gray))
                
            
            Spacer()
            
            Button {
                if title != "" {
                    realmManager.addTask(taskTitle: title, taskDetail: detail)
                    print("Non-empty Task added!")
                }
                dismiss()
            } label: {
                if title != "" {
                    Text("Add task")
                        .foregroundColor(.white).bold()
                        .padding()
                        .padding(.horizontal, 80)
                        .background(Color(hue: 1.0, saturation:  0.0, brightness:  0.1  ))
                        .cornerRadius(30)
                } else {
                    Text("Cancel")
                        .foregroundColor(.white).bold()
                        .padding()
                        .padding(.horizontal, 80)
                        .background(Color(hue: 1.0, saturation:  0.0, brightness:  0.1  ))
                        .cornerRadius(30)
                }
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            
            //Spacer()
            
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.92))

    }
}

// Create TextView

struct MultilineTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        view.font = UIFont.systemFont(ofSize: 18)
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: MultilineTextView
        
        init(_ textView: MultilineTextView) {
            self.parent = textView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
