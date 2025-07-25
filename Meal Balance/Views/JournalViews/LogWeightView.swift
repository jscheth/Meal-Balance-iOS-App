//
//  LogWeightView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct LogWeightView: View {
    @State private var selectedWeight = 170
    var body: some View {
        VStack {
            Text("Log Your Weight").font(.largeTitle).bold()
            Picker("Weight", selection: $selectedWeight) {
                ForEach(80..<401) { weight in
                    Text("\(weight) lbs").tag(weight)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .colorScheme(.dark)
            Spacer()
            Button(action: {
                // Add logic to save the weight entry to Firestore.
            }) {
                Text("Save Weight").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity)
                    .padding().background(Color.blue).cornerRadius(12)
            }.padding()
        }
        .navigationTitle("Log Weight")
    }
}
