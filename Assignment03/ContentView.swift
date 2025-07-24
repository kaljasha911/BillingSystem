import SwiftUI

//  ContentView.swift
//  Assignment03
//  Created by Jashan Kalsi on 2025-07-23.
//  Student ID: [Your Student ID Here]

struct ContentView: View {
    
    // State variable to toggle between Tiered (true) and TOU (false) pricing plans
    @State private var isTiered: Bool = true
    
    // TOU Inputs
    @State private var onPeak: String = ""
    @State private var offPeak: String = ""
    @State private var midPeak: String = ""
    
    // Tiered Input
    @State private var totalUsage: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                // Toggle Section
                Section {
                    Toggle("Tiered Pricing? Yes/ No?", isOn: $isTiered)
                }
                
                // Input Section based on Pricing Plan
                if isTiered {
                    Section(header: Text("Tiered Plan Input")) {
                        TextField("Total usage (kWh)", text: $totalUsage)
                            .keyboardType(.decimalPad)
                    }
                } else {
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
                    Text("Consumption Charges: $\(consumptionCharges, specifier: "%.2f")")
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
    
    /// Calculates charges for Time-of-Use plan based on usage in three periods
    var touCharges: Double {
        let on = Double(onPeak) ?? 0.0
        let off = Double(offPeak) ?? 0.0
        let mid = Double(midPeak) ?? 0.0
        return (on * 0.158) + (off * 0.076) + (mid * 0.122)
    }
    
    /// Calculates charges for Tiered plan based on total usage with a 600 kWh threshold
    var tieredCharges: Double {
        let usage = Double(totalUsage) ?? 0.0
        if usage <= 600 {
            return usage * 0.093
        } else {
            return (600 * 0.093) + ((usage - 600) * 0.11)
        }
    }
    
    /// Determines consumption charges based on the selected pricing plan
    var consumptionCharges: Double {
        isTiered ? tieredCharges : touCharges
    }
    
    /// Calculates the provincial rebate as 13.1% of consumption charges
    var provincialRebate: Double {
        0.131 * consumptionCharges
    }
    
    /// Calculates HST as 13% of (consumption charges - provincial rebate)
    var hst: Double {
        0.13 * (consumptionCharges - provincialRebate)
    }
    
    /// Calculates total regulatory charges as HST - provincial rebate
    var regulatoryCharges: Double {
        hst - provincialRebate
    }
    
    /// Calculates the total bill as consumption charges + regulatory charges
    var totalBill: Double {
        consumptionCharges + regulatoryCharges
    }
}

#Preview {
    ContentView()
}
