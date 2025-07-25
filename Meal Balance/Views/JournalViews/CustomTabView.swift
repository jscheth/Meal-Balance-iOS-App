//
//  CustomTabView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

enum Tab {
    case dashboard, journal, goals, more
}

struct CustomTabView: View {
    // This binding will hold the currently selected tab.
    @Binding var selectedTab: Tab
    // This state variable controls whether the "Add Food" modal is shown.
    @State private var isAddFoodSheetPresented = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // This is where the main content of the selected tab will be displayed.
            Group {
                switch selectedTab {
                case .dashboard:
                    DashboardView()
                case .journal:
                    JournalView()
                case .goals:
                    GoalsView()
                case .more:
                    MoreView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // This HStack creates the custom tab bar UI.
            HStack {
                TabButton(tab: .dashboard, selectedTab: $selectedTab, imageName: "square.grid.2x2.fill", title: "Dashboard")
                TabButton(tab: .journal, selectedTab: $selectedTab, imageName: "book.fill", title: "Journal")
                
                // The central "Add Food" button.
                AddFoodButton(isPresented: $isAddFoodSheetPresented)
                
                TabButton(tab: .goals, selectedTab: $selectedTab, imageName: "target", title: "Goals")
                TabButton(tab: .more, selectedTab: $selectedTab, imageName: "ellipsis", title: "More")
            }
            .padding()
            .background(Color(.secondarySystemBackground).clipShape(Capsule()))
            .padding(.horizontal)
            .shadow(radius: 10)
        }
        // This presents the AddFoodView as a modal sheet.
        .sheet(isPresented: $isAddFoodSheetPresented) {
            AddFoodView()
        }
    }
}

// A helper view for the standard tab buttons.
struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let imageName: String
    let title: String

    var body: some View {
        Button(action: { selectedTab = tab }) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .font(.title2)
                Text(title)
                    .font(.caption2)
            }
            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// The central "+" button.
struct AddFoodButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button(action: { isPresented.toggle() }) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 56, height: 56)
                    .shadow(radius: 4)
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
            }
        }
        .offset(y: -25) // Lifts the button up.
    }
}
