//
//  CalculatingPlanView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct CalculatingPlanView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var isReadyToNavigate = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Text("Awesome!").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                Text("We are Cooking Up Your Plan").font(.title2).foregroundColor(.gray).padding(.top, 5)
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white)).scaleEffect(1.5).padding(.top, 40)
                Text("Calculating energy expenditure...").font(.subheadline).foregroundColor(.gray).padding(.top, 20)
                Spacer()
            }.padding()
            .onAppear {
                viewModel.calculateMacros()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.isReadyToNavigate = true }
            }
            .background(NavigationLink(destination: MacroTargetsView(), isActive: $isReadyToNavigate) { EmptyView() })
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        CalculatingPlanView()
    }
}
