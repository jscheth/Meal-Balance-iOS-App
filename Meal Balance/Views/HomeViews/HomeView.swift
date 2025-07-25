//
//  HomeView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct HomeView: View {
    // This state variable will keep track of which tab is currently selected.
    // It defaults to the dashboard, which is the first screen the user sees.
    @State private var selectedTab: Tab = .dashboard

    var body: some View {
        // Instead of the standard TabView, we now call our custom implementation.
        // We pass the 'selectedTab' state as a binding, so the CustomTabView
        // can both read and change the currently active tab.
        CustomTabView(selectedTab: $selectedTab)
    }
}

#Preview {
    // The preview needs an instance of the data model to work correctly.
    HomeView()
        .environmentObject(OnboardingViewModel())
        .preferredColorScheme(.dark)
}
