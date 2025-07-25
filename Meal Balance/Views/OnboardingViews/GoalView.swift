//
//  GoalView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct GoalView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedGoal: String?
    let goals = ["Gain Weight", "Lose Weight", "Maintain Weight"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Text("What can we help you achieve?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding(.bottom)
                Text("This information helps us create a suitable plan for you.").font(.headline).foregroundColor(.gray).padding(.bottom, 40)
                ForEach(goals, id: \.self) { goal in
                    Button(action: {
                        self.selectedGoal = goal
                        viewModel.goal = goal // Save selection to the data model
                    }) {
                        Text(goal).font(.headline).foregroundColor(self.selectedGoal == goal ? .white : .primary).padding().frame(maxWidth: .infinity)
                            .background(self.selectedGoal == goal ? Color.blue : Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                }
                Spacer()
                NavigationLink(destination: GoalInfoView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity)
                        .background(selectedGoal == nil ? Color.gray : Color.blue).cornerRadius(12)
                }.disabled(selectedGoal == nil).padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    GoalView()
}
