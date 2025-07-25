//
//  MacroTargetsView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct MacroTargetsView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    private func getPercentage(for macroGrams: Int, isFat: Bool = false) -> String {
        let totalCals = Double(viewModel.calories)
        guard totalCals > 0 else { return "0%" }
        
        let caloriesPerGram = isFat ? 9.0 : 4.0
        let macroCals = Double(macroGrams) * caloriesPerGram
        let percentage = (macroCals / totalCals * 100)
        return "\(Int(round(percentage)))%"
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Your macro targets are ready!").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center).padding()
                VStack(spacing: 15) {
                    MacroRow(name: "Protein", value: "\(viewModel.protein) g", percentage: getPercentage(for: viewModel.protein), color: .pink)
                    MacroRow(name: "Carbs", value: "\(viewModel.carbs) g", percentage: getPercentage(for: viewModel.carbs), color: .cyan)
                    MacroRow(name: "Fat", value: "\(viewModel.fat) g", percentage: getPercentage(for: viewModel.fat, isFat: true), color: .green)
                    MacroRow(name: "Calories", value: "\(viewModel.calories) Cal", percentage: "100%", color: .orange)
                }.padding().background(Color(.secondarySystemBackground)).cornerRadius(12).padding()
                Text("The information provided here is for informational purposes only...").font(.caption).foregroundColor(.gray).multilineTextAlignment(.center).padding()
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {}) {
                        Text("Edit Target").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 1))
                    }
                    NavigationLink(destination: CongratulationsView()) {
                        Text("Looks good!").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                    }
                }.padding(.horizontal)
            }.padding()
        }.navigationBarBackButtonHidden(true)
    }
}

// This is a helper view to create a consistent style for each row in the macro grid.
struct MacroRow: View {
    let name: String
    let value: String
    let percentage: String
    let color: Color

    var body: some View {
        HStack {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(name).foregroundColor(.white)
            Spacer()
            Text(value).fontWeight(.bold).foregroundColor(.white)
            Text(percentage).frame(width: 60, alignment: .trailing).foregroundColor(.gray)
        }
    }
}


#Preview {
    NavigationView {
        MacroTargetsView()
            .environmentObject(OnboardingViewModel())
    }
}
