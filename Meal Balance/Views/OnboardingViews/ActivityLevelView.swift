//
//  ActivityLevelView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct ActivityLevelView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedActivity: ActivityLevel?

    enum ActivityLevel: String, CaseIterable {
        case notVery = "Not very active", moderately = "Moderately active", active = "Active", veryActive = "Very active"
        var description: String {
            switch self {
            case .notVery: return "Normal everyday activity like walking, stairs, etc."
            case .moderately: return "Burns an additional 250-500 calories."
            case .active: return "Burns an additional 500-800 calories."
            case .veryActive: return "Burns more than 800 additional calories."
            }
        }
        var multiplier: Double {
            switch self {
            case .notVery: return 1.2
            case .moderately: return 1.375
            case .active: return 1.55
            case .veryActive: return 1.725
            }
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Text("How active are you?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding([.horizontal, .bottom])
                ForEach(ActivityLevel.allCases, id: \.self) { level in
                    Button(action: {
                        self.selectedActivity = level
                        viewModel.activityLevelMultiplier = level.multiplier
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(level.rawValue).font(.headline)
                            Text(level.description).font(.subheadline).opacity(0.8)
                        }.padding().frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(selectedActivity == level ? .white : .primary)
                        .background(selectedActivity == level ? Color.blue : Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                }
                Spacer()
                NavigationLink(destination: WeightLiftingView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                        .background(selectedActivity == nil ? Color.gray : Color.blue).cornerRadius(12)
                }.disabled(selectedActivity == nil).padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        ActivityLevelView()
    }
}
