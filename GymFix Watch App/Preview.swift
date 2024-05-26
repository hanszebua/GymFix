//
//  Preview.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 21/05/24.
//

import SwiftUI

struct Preview: View {
    
    @State private var currentIndex = 0
    let images = ["biceps down", "biceps full"]
    let hexCode = Color(red: 64/255, green: 64/255, blue: 64/255)
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 100)
                        .padding()
                        .onAppear {
                            withAnimation {
                                currentIndex = (currentIndex + 1) % images.count
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.body
                            }
                    }
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 125)
                .background(hexCode)
                .cornerRadius(10)
                
                NavigationLink{Rep_Picker()}label:
                {
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
    Preview()
}
