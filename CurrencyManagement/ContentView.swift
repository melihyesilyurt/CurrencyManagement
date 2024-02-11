//
//  ContentView.swift
//  CurrencyManagement
//
//  Created by Melih Yesilyurt on 11.02.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var amountInput: String = ""
    @State private var convertedAmount: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            TextField("Miktarı Girin", text: $amountInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text ("Dönüştürülen Miktar: \(convertedAmount)")
                .foregroundColor(.green)
                .padding()
            Text ("\(errorMessage)")
                .foregroundColor(.red)
                .padding()
            Button(action: {
                guard let amount = Int(amountInput) else {
                    errorMessage = "Geçersiz Değer Girdiniz!!"
                    convertedAmount = "0"
                    return
                }
                convertCurrency(fromCurrencyType: "USD", toCurrencyType: "TRY", amount: amount) {
                    result in
                    switch result {
                    case .success(let amount):
                        convertedAmount = "\(amount)"
                        errorMessage = ""
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text("Dönüştür")
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
