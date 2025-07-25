//
//  HeightView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct HeightView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedUnit: Int = 0
    let units = ["Feet and Inches", "Centimeters"]
    @State private var feet: Int = 5
    @State private var inches: Int = 8
    @State private var centimeters: Int = 173

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("What is your height?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center).padding()
                Picker("Unit", selection: $selectedUnit) {
                    ForEach(0..<units.count, id: \.self) { Text(self.units[$0]) }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                if selectedUnit == 0 {
                    HStack {
                        Picker("Feet", selection: $feet) { ForEach(3..<8) { Text("\($0) ft").tag($0) } }.pickerStyle(WheelPickerStyle()).frame(maxWidth: .infinity)
                        Picker("Inches", selection: $inches) { ForEach(0..<12) { Text("\($0) in").tag($0) } }.pickerStyle(WheelPickerStyle()).frame(maxWidth: .infinity)
                    }.colorScheme(.dark).id("feetAndInchesPicker")
                } else {
                    Picker("Centimeters", selection: $centimeters) { ForEach(90..<241) { Text("\($0) cm").tag($0) } }.pickerStyle(WheelPickerStyle()).colorScheme(.dark).id("cmPicker")
                }
                Spacer()
                NavigationLink(destination: ActivityLevelView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
            }.padding()
            .onAppear(perform: updateHeightInViewModel)
            .onChange(of: feet) { _ in updateHeightInViewModel() }
            .onChange(of: inches) { _ in updateHeightInViewModel() }
            .onChange(of: centimeters) { _ in updateHeightInViewModel() }
            .onChange(of: selectedUnit) { _ in updateHeightInViewModel() }
        }.navigationBarTitle("", displayMode: .inline)
    }
    
    private func updateHeightInViewModel() {
        if selectedUnit == 0 {
            let totalInches = Double(feet * 12 + inches)
            viewModel.heightCm = totalInches * 2.54
        } else {
            viewModel.heightCm = Double(centimeters)
        }
    }
}

#Preview {
    NavigationView {
        // The preview now provides the necessary data model.
        HeightView()
            .environmentObject(OnboardingViewModel())
    }
    .preferredColorScheme(.dark)
}
