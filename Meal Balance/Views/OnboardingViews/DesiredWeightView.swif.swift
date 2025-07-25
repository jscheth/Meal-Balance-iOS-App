//
//  DesiredWeightView.swif.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct DesiredWeightView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedUnitIndex: Int = 0
    let units = ["lbs", "kg"]
    @State private var selectedWeight: Int = 150

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("What is your desired weight?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center).padding()
                Picker("Unit", selection: $selectedUnitIndex) {
                    ForEach(0..<units.count, id: \.self) { Text(self.units[$0]) }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                .onChange(of: selectedUnitIndex) { newIndex in
                    viewModel.displayUnit = units[newIndex]
                    selectedWeight = units[newIndex] == "lbs" ? 150 : 68
                }

                Picker("Weight", selection: $selectedWeight) {
                    ForEach(units[selectedUnitIndex] == "lbs" ? 80..<401 : 35..<181, id: \.self) { weight in
                        Text("\(weight) \(self.units[self.selectedUnitIndex])").tag(weight)
                    }
                }.pickerStyle(WheelPickerStyle()).colorScheme(.dark).padding(.horizontal, -15).id(selectedUnitIndex)

                Spacer()
                NavigationLink(destination: GoalConfirmationView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
                
            }.padding()
            .onAppear {
                self.selectedUnitIndex = viewModel.displayUnit == "lbs" ? 0 : 1
                updateWeightInViewModel()
            }
            .onChange(of: selectedWeight) { _ in updateWeightInViewModel() }
            
        }.navigationBarTitle("", displayMode: .inline)
    }
    
    private func updateWeightInViewModel() {
        if units[selectedUnitIndex] == "lbs" {
            viewModel.desiredWeightKg = Double(selectedWeight) * 0.453592
        } else {
            viewModel.desiredWeightKg = Double(selectedWeight)
        }
    }
}

#Preview {
    NavigationView {
        // The preview now provides the necessary data, which fixes the error.
        DesiredWeightView()
            .environmentObject(OnboardingViewModel())
    }
    .preferredColorScheme(.dark)
}
