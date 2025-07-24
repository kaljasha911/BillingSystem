//
//  ContentView.swift
//  Assignment03
//
//  Created by Jashan Kalsi on 2025-07-23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isTOU: Bool = true
    
    // TOU Inputs
    @State private var onPeak: String = ""
    @State private var offPeak: String = ""
    @State private var midPeak: String = ""
    
    // Tiered Inputs
    @State private var totalUsage: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Tiered Pricing? Yes/ No?", isOn: $isTOU)
                }
                
                if isTOU {
                    // TOU Input Section
                    Section(header: Text("Tiered Plan Input")) {
                        TextField("Total usage (kWh)", text: $totalUsage)
                            .keyboardType(.decimalPad)
                    }
                }
                else {
                    Section(header: Text("Time-Of-Use Inputs")) {
                        TextField("On-peak usage (kWh)", text: $onPeak)
                                .keyboardType(.decimalPad)
                        TextField("Off-peak usage (kWh)", text: $offPeak)
                                .keyboardType(.decimalPad)
                        TextField("Mid-peak usage (kWh)", text: $midPeak)
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                // Results Section
                Section(header: Text("Bill Details")) {
                    
                }
            }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
