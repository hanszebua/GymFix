//
//  Info_success.swift
//  GymFix Watch App
//
//  Created by Hans Zebua on 24/05/24.
//

import SwiftUI
import WatchKit

struct Info_success: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("This means you're on the right pace of reps.")
                    .foregroundColor(.green)
                    .fontDesign(.rounded)
                Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFill()
                    .padding(10)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        WKInterfaceDevice.current().play(.success)
                    }
                Spacer()
                NavigationLink{info_fail()}label:
                {
                    Text("Next")
                }
                .background(Color.orange)
                .cornerRadius(50)
            }
            .padding()
        }
        .onAppear(perform: {
            WKInterfaceDevice.current().play(.success)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Info_success()
}
