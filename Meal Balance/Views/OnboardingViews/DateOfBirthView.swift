//
//  DateOfBirthView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct DateOfBirthView: View {
    // Connect to the shared data model from the environment.
    @EnvironmentObject var viewModel: OnboardingViewModel

    // Define a valid date range: from 100 years ago to 13 years ago.
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let hundredYearsAgo = calendar.date(byAdding: .year, value: -100, to: Date())!
        let thirteenYearsAgo = calendar.date(byAdding: .year, value: -13, to: Date())!
        return hundredYearsAgo...thirteenYearsAgo
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("When were you born?")
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(.white).multilineTextAlignment(.center).padding()
                
                // The DatePicker now directly saves its value to the viewModel.
                DatePicker(
                    "Date of Birth",
                    selection: $viewModel.dateOfBirth, // Bind to the ViewModel
                    in: dateRange,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle()) // Use the wheel style as requested
                .labelsHidden()
                // Using .colorScheme(.dark) is the reliable fix for visibility.
                .colorScheme(.dark)
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: HeightView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
                
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        // The preview now provides the necessary data model, which fixes the error.
        DateOfBirthView()
            .environmentObject(OnboardingViewModel())
    }
    .preferredColorScheme(.dark)
}
