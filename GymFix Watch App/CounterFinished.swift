//
//  CounterFinished.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 24/05/24.
//

import SwiftUI

struct CounterFinished: View {
    var body: some View {
        VStack {
            Text("Nice Job!")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontDesign(.rounded)
            Spacer()
            NavigationLink{Summary()}label:
            {
                Text("Next")
            }
            .background(Color.orange)
            .cornerRadius(50)
            .padding()
            .navigationBarBackButtonHidden(true)
        }
        .padding(15)
    }
}

//#Preview {
//    CounterFinished()
//}
