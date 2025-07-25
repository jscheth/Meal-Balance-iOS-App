//
//  AppleHealthSyncView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct AppleHealthSyncView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "checkmark.shield.fill").font(.system(size: 80)).foregroundColor(.green).padding()
                Text("First, sync your data").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).padding(.top)
                Text("Meal Balance can sync your weight from Apple Health and save your nutrition data back.").font(.body).foregroundColor(.gray).multilineTextAlignment(.center).padding()
                Spacer()
                let nextScreen = CurrentWeightView()
                NavigationLink(destination: nextScreen) {
                    Text("Sync").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
                NavigationLink(destination: nextScreen) {
                    Text("Maybe Later").font(.headline).foregroundColor(.gray).padding()
                }
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    AppleHealthSyncView()
}
