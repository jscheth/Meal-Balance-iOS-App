//
//  WelcomeView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "scalemass.fill")
                    .resizable().scaledToFit().frame(width: 100, height: 100)
                    .padding(.bottom, 30).foregroundColor(.accentColor)
                Text("Meal Balance").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                Text("Take Control of your Nutrition").font(.title2).foregroundColor(.secondary).padding(.bottom, 50)
                Spacer()
                NavigationLink(destination: GoalView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity)
                        .padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
                NavigationLink(destination: SignInView()) {
                    Text("Already a Meal Balance User? Sign In").font(.footnote).foregroundColor(.secondary)
                }.padding(.top)
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    WelcomeView()
}
