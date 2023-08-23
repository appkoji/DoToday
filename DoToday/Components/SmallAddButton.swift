//
//  SmallAddButton.swift
//  DoToday
//
//  Created by 村田興児 on 2023/08/21.
//

import SwiftUI

struct SmallAddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 70)
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 30))
        }
        .frame(height: 70)
    }
}

struct SmallAddButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallAddButton()
    }
}
