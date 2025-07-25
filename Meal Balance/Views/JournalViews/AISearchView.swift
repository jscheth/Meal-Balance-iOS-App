//
//  AISearchView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct AISearchView: View {
    @State private var aiQuery = ""
    var body: some View {
        VStack {
            Text("Describe your meal in plain language.")
                .font(.headline)
                .foregroundColor(.secondary)
            TextEditor(text: $aiQuery)
                .frame(height: 150)
                .cornerRadius(12)
                .padding()
            Button(action: {
                // Add logic to send the query to an AI model.
            }) {
                Text("Log with AI").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity)
                    .padding().background(Color.blue).cornerRadius(12)
            }.padding()
            Spacer()
        }
        .navigationTitle("AI Search")
    }
}
