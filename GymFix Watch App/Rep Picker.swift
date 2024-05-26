//
//  Rep Picker.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI

struct Rep_Picker: View {
    @State private var value = 1

    var body: some View {
        NavigationStack {
            VStack {
                Text("Number of Reps:")
                Stepper(value: $value, in: 1...15, step: 1) {
                    Text("\(value)")
                }
                .padding(10)
                NavigationLink {
                    RepCounter(targetReps: value)
                } label: {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
                .padding()
            }
        }
    }
}

#Preview {
    Rep_Picker()
    
}
