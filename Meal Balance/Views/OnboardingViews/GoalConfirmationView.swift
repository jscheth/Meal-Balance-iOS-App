//
//  GoalConfirmationView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct GoalConfirmationView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    private var weightDifference: Int {
        let differenceInKg = abs(viewModel.currentWeightKg - viewModel.desiredWeightKg)
        if viewModel.displayUnit == "lbs" {
            return Int(round(differenceInKg * 2.20462))
        } else {
            return Int(round(differenceInKg))
        }
    }
    
    private var goalAction: String {
        viewModel.currentWeightKg > viewModel.desiredWeightKg ? "Losing" : "Gaining"
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Text("\(goalAction) \(weightDifference) \(viewModel.displayUnit) is an achievable goal!").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center).padding(.horizontal)
                Text("We're here to help you every step of the journey.").font(.title3).foregroundColor(.gray).multilineTextAlignment(.center).padding(.top, 20).padding(.horizontal)
                Spacer()
                Text("Just a few more questions...").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal).padding(.bottom, 20)
                NavigationLink(destination: GenderSelectionView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        // The preview now correctly provides the data model, which fixes the error.
        GoalConfirmationView()
            .environmentObject(OnboardingViewModel())
    }
    .preferredColorScheme(.dark)
}
