//
//  PersonalizationIntroView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct PersonalizationIntroView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: "person.text.rectangle.fill").font(.system(size: 100)).foregroundColor(.blue).padding(.bottom, 40)
                Text("Let's get to know you").font(.largeTitle).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                Text("so we can create your personalized plan.").font(.title2).foregroundColor(.gray).multilineTextAlignment(.center).padding(.top, 5)
                Spacer()
                Spacer()
                NavigationLink(destination: AppleHealthSyncView()) {
                    Text("Continue").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }.padding(.horizontal)
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    PersonalizationIntroView()
}
