//
//  info_fail.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 24/05/24.
//

import SwiftUI

struct info_fail: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("This means you're too fast.")
                    .foregroundColor(.red)
                    .fontDesign(.rounded)
                Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFill()
                    .padding(10)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        WKInterfaceDevice.current().play(.failure)
                    }

                NavigationLink{Exercises_picker()}label:
                {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
            }
            .padding()
        }
        .onAppear(perform: {
            WKInterfaceDevice.current().play(.failure)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    info_fail()
}
