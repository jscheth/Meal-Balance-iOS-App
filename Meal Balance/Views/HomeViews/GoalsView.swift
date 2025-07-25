//
//  GoalsView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("My Macros")
                        .font(.title).bold()
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Daily Targets").font(.headline)
                        
                        // Display the user's goals from the ViewModel.
                        HStack {
                            GoalDetailView(label: "Protein", value: "\(viewModel.protein)g")
                            GoalDetailView(label: "Carbs", value: "\(viewModel.carbs)g")
                        }
                        HStack {
                            GoalDetailView(label: "Fat", value: "\(viewModel.fat)g")
                            GoalDetailView(label: "Calories", value: "\(viewModel.calories)")
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("My Goals")
            .toolbar {
                // Button to allow editing goals.
                Button(action: {}) {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

// A helper view for displaying a single goal.
struct GoalDetailView: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption).foregroundColor(.secondary)
            Text(value).font(.title2).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    GoalsView()
        .environmentObject(OnboardingViewModel())
        .preferredColorScheme(.dark)
}
