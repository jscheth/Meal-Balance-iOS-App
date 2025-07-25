//
//  GoalInfoView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct GoalInfoView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Text("A balanced approach to achieving your goal.").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center).foregroundColor(.white).padding(.horizontal)
                Text("Achieving your weight goals is a journey of consistency, not restriction. Meal Balance provides the tools to understand your eating habits, making it simple to build a sustainable, healthy lifestyle that works for you.").font(.body).foregroundColor(.gray).multilineTextAlignment(.center).padding(.top).padding(.horizontal)
                Spacer()
                Spacer()
                NavigationLink(destination: FeatureInfoView()) {
                     Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    GoalInfoView()
}
