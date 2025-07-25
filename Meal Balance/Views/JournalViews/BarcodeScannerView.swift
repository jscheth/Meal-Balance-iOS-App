//
//  BarcodeScannerView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera.viewfinder")
                .font(.system(size: 150))
                .foregroundColor(.secondary)
            Text("A live camera feed would appear here to scan product barcodes.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle("Scan Barcode")
    }
}
