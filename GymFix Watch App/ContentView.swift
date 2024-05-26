//
//  ContentView.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView {
                    Text("Instructions")
                        .fontDesign(.rounded)
                        .font(.headline)
                    Text("control the weight(1-2 seconds between reps)")
                        .foregroundColor(.secondary)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                }
                Spacer()
                NavigationLink{Info_success()}label:
                {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
