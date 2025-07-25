//
//  FeatureInfoView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct FeatureInfoView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 25) {
                Spacer()
                Text("With Meal Balance you get...").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding(.bottom, 20)
                FeatureRow(iconName: "bolt.fill", title: "Effortless Food Logging", description: "Our streamlined process makes tracking meals faster than ever.")
                FeatureRow(iconName: "magnifyingglass", title: "A Verified Food Database", description: "Access millions of food items, verified for accuracy.")
                FeatureRow(iconName: "chart.pie.fill", title: "Insightful Nutrition Reports", description: "Visualize your progress with clear, advanced reporting.")
                Spacer()
                Spacer()
                NavigationLink(destination: PersonalizationIntroView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

// A reusable view for displaying a feature with an icon
struct FeatureRow: View {
    let iconName: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 40)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    FeatureInfoView()
}
