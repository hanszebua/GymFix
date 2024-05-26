//
//  Exercises_picker.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI
import WatchKit

struct Exercises_picker: View {
    
    @State private var selectedExerciseIndexDouble = 1.0

    
    var body: some View {
        NavigationStack {
            VStack {
                // picker exercises
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Choose the exercises")
                    .padding(.bottom)
                    .fontDesign(.rounded)
                ) {
                    Text("Bicep Curls").tag(1)
                    Text("Lateral Raises").tag(2)
                    Text("Shoulder Press").tag(3)
                }
                .digitalCrownRotation($selectedExerciseIndexDouble, from: 1.0, through: 3.0, by: 1.0, sensitivity: .high, isContinuous: true, isHapticFeedbackEnabled: true)
                .padding(.bottom, 10)


                
                NavigationLink{Preview()}label:
                {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
                .padding()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: selectedExerciseIndexDouble) { newValue in
                    let newIndex = Int(round(newValue))
                    if newIndex >= 1 && newIndex <= 3 {
                        selectedExerciseIndexDouble = Double(newIndex)
                    }
            }
    }
}

#Preview {
    Exercises_picker()
}
