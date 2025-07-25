//
//  GenderConfirmationView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct GenderSelectionView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedGender: String?
    let genders = ["Male", "Female", "Other/Non-binary"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Text("What is your sex?").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding(.bottom, 40)
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        self.selectedGender = gender
                        viewModel.gender = gender
                    }) {
                        Text(gender).font(.headline).foregroundColor(self.selectedGender == gender ? .white : .primary).padding().frame(maxWidth: .infinity)
                            .background(self.selectedGender == gender ? Color.blue : Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                }
                Spacer()
                NavigationLink(destination: DateOfBirthView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity)
                        .background(selectedGender == nil ? Color.gray : Color.blue).cornerRadius(12)
                }.disabled(selectedGender == nil).padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    // Corrected to call the correct struct name
    NavigationView {
        GenderSelectionView()
    }
}
