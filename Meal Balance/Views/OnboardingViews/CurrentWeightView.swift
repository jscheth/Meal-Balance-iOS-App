//
//  CurrentWeightView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct CurrentWeightView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedUnitIndex: Int = 0
    let units = ["lbs", "kg"]
    @State private var selectedWeight: Int = 170

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("What is your current weight?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center).padding()
                Picker("Unit", selection: $selectedUnitIndex) {
                    ForEach(0..<units.count, id: \.self) { Text(self.units[$0]) }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                .onChange(of: selectedUnitIndex) { newIndex in
                    viewModel.displayUnit = units[newIndex]
                    selectedWeight = units[newIndex] == "lbs" ? 170 : 77
                }
                
                Picker("Weight", selection: $selectedWeight) {
                    ForEach(units[selectedUnitIndex] == "lbs" ? 80..<401 : 35..<181, id: \.self) { weight in
                        Text("\(weight) \(self.units[self.selectedUnitIndex])").tag(weight)
                    }
                }.pickerStyle(WheelPickerStyle()).colorScheme(.dark).padding(.horizontal, -15).id(selectedUnitIndex)
                
                Spacer()
                NavigationLink(destination: DesiredWeightView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
                
            }.padding()
            .onAppear(perform: updateWeightInViewModel)
            .onChange(of: selectedWeight) { _ in updateWeightInViewModel() }
            
        }.navigationBarTitle("", displayMode: .inline)
    }
    
    private func updateWeightInViewModel() {
        if units[selectedUnitIndex] == "lbs" {
            viewModel.currentWeightKg = Double(selectedWeight) * 0.453592
        } else {
            viewModel.currentWeightKg = Double(selectedWeight)
        }
    }
}

#Preview {
    NavigationView {
        // The preview now correctly provides the data model, fixing the error.
        CurrentWeightView()
            .environmentObject(OnboardingViewModel())
    }
    .preferredColorScheme(.dark)
}
