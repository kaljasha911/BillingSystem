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
                // Results Section
                Section(header: Text("Bill Details")) {
                    Text("Consumotion Charges: $\(consumptionCharges, specifier: "%.2f")")
                    Text("Provincial Rebate (13.1%): $\(provincialRebate, specifier: "%.2f")")
                    Text("HST (13%): $\(hst, specifier: "%.2f")")
                    Text("Regulatory Charges: $\(regulatoryCharges, specifier: "%.2f")")
                    Text("Total Bill: $\(totalBill, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Energy Bill Calculator")
        }
        
    }
    
    // MARK: - Computed Properties
    
    var touCharges: Double {
        let on = Double(onPeak) ?? 0.0
        let off = Double(offPeak) ?? 0.0
        let mid = Double(midPeak) ?? 0.0
        
        return (on * 0.158) + (off * 0.076) + (mid * 0.122)
    }
    
    var tieredCharges: Double {
        let usage = Double(totalUsage) ?? 0
        
        if usage <= 600 {
            return usage * 0.093
        } else {
            return (600 * 0.093) + ((usage - 600) * 0.11)
        }
    }
    
    var consumptionCharges: Double {
        isTOU ? touCharges : tieredCharges
    }
    
    var provincialRebate: Double {
        0.131 * consumptionCharges
    }
    
    var hst: Double {
        0.13 * (consumptionCharges - provincialRebate)
    }
    
    var regulatoryCharges: Double {
        hst - provincialRebate
    }
    
    var totalBill: Double {
        consumptionCharges + regulatoryCharges
    }
}
    
#Preview {
        ContentView()
}
    
