//
//  WeightLiftingView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct WeightLiftingView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var liftsWeights: Bool?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Text("Do you lift weights?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding(.bottom, 10)
                Text("We will optimize your protein target for your strength training routine.").font(.body).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal).padding(.bottom, 40)
                HStack(spacing: 20) {
                    Button(action: { self.liftsWeights = true; viewModel.liftsWeights = true }) {
                        Text("Yes").font(.headline).foregroundColor(self.liftsWeights == true ? .white : .primary).padding().frame(maxWidth: .infinity)
                            .background(self.liftsWeights == true ? Color.blue : Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                    Button(action: { self.liftsWeights = false; viewModel.liftsWeights = false }) {
                        Text("No").font(.headline).foregroundColor(self.liftsWeights == false ? .white : .primary).padding().frame(maxWidth: .infinity)
                            .background(self.liftsWeights == false ? Color.blue : Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                }.padding(.horizontal)
                Spacer()
                NavigationLink(destination: CalculatingPlanView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                        .background(liftsWeights == nil ? Color.gray : Color.blue).cornerRadius(12)
                }.disabled(liftsWeights == nil).padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        WeightLiftingView()
    }
}
