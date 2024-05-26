//
//  Summary.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI

struct Summary: View {
    
    let hexCode = Color(red: 64/255, green: 64/255, blue: 64/255)
    
    var body: some View {
        NavigationStack{
            ZStack {
                
            }
            VStack {
                Text("Summary:")
                    .padding(.bottom, 20)
                VStack {
                    HStack{
                        Text("Well Timed")
                        Spacer()
                        Text("#")
                    }
                    .foregroundColor(.green)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 5)
                    Divider()
                        .frame(height: 3)
                        .padding(.horizontal, 30)
                        .background(Color.black)
                        .opacity(0.5)
                    HStack{
                        Text("Too Fast")
                        Spacer()
                        Text("#")
                    }.padding(.horizontal, 10)
                        .foregroundColor(.red)
                }
                .frame(width: 175, height: 75)
                .background(hexCode)
                .cornerRadius(10)
                .padding(.bottom, 20)
                
                NavigationLink{Exercises_picker()}label: {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
                .padding()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Summary()
}
