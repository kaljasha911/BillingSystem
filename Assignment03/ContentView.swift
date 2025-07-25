import SwiftUI

//  ContentView.swift
//  Assignment03
//  Created by Jashan Kalsi on 2025-07-23.
//  Student ID: 991494313

struct ContentView: View {
    // MARK: - State Variables
    
    // State variable to toggle between Tiered (true) and TOU (false) pricing plans
    @State private var isTiered: Bool = true
    
    // TOU (Time-Of-Use) Inputs
    @State private var onPeak: String = ""
    @State private var offPeak: String = ""
    @State private var midPeak: String = ""
    
    // Tiered plan Input
    @State private var totalUsage: String = ""
    
    var body: some View {
            NavigationView {
                Form {
                    // Toggle Section
                    Section {
                        // Toggle to switch between Tiered and TOU pricing
                        Toggle("Tiered Pricing? YES --> ", isOn: $isTiered)
                    }
                    
                    // Usage Input Section based on Pricing Plan
                    if isTiered {
                        // If Tiered plan selected, input total usage
                        Section(header: Text("Usage Details")) {
                            TextField("Total usage (kWh)", text: $totalUsage)
                                .keyboardType(.decimalPad)
                        }
                            // Results Section
                        Section(header: Text("Consumption Charges")) {
                            Text("Tier1 charges: $\(tierOneCharges, specifier: "%.2f")")
                            Text("Tier2 charges: $\(tierTwoCharges, specifier: "%.2f")")
                            Text("Total Consumption Charges: $\(consumptionCharges, specifier: "%.2f")")
                                .foregroundStyle(.blue)
                                .fontWeight(.bold)
                            }
                        
                    } else {
                        // If TOU plan selected, input for three periods
                        Section(header: Text("Usage Details")) {
                            TextField("On-peak usage (kWh)", text: $onPeak)
                                .keyboardType(.decimalPad)
                            TextField("Off-peak usage (kWh)", text: $offPeak)
                                .keyboardType(.decimalPad)
                            TextField("Mid-peak usage (kWh)", text: $midPeak)
                                .keyboardType(.decimalPad)
                        }
                        // MARK: - TOU Charges Display
                        Section(header: Text("Consumption Charges")) {
                            Text("On-peak charges: $\(onPeakAmount, specifier: "%.2f")")
                            Text("Off-peak charges: $\(offPeakAmount, specifier: "%.2f")")
                            Text("Mid-peak charges: $\(midPeakAmount, specifier: "%.2f")")
                            Text("Total Consumption Charges: $\(consumptionCharges, specifier: "%.2f")")
                                .foregroundStyle(.blue)
                                .fontWeight(.bold)
                        }
                    }
                    // MARK: - Regulatory Charges Section
                    Section(header: Text("Regulatory & Tax Charges")) {
                        Text("Provincial Rebate (13.1%): $\(provincialRebate, specifier: "%.2f")")
                        Text("HST (13%): $\(hst, specifier: "%.2f")")
                        Text("Total Regulatory Charges: $\(regulatoryCharges, specifier: "%.2f")")
                            .foregroundStyle(.blue)
                            .fontWeight(.bold)
                        }
                    // MARK: - Final Bill Section
                    Section(header: Text("Bill Amount")) {
                        Text("Net Bill Amount: $\(totalBill, specifier: "%.2f")")
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                    }
                }
                // Navigation bar setup with the help of swift.org
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("John Smith")
                            .font(.system(size: 17, weight: .bold))
                }
            }
        }
    }
    
    // MARK: - Computed Properties
    
    // Calculates charges for Time-of-Use plan based on usage in three periods
    var touCharges: Double {
        let on = max(Double(onPeak) ?? 0.0, 0.0)
        let off = max(Double(offPeak) ?? 0.0, 0.0)
        let mid = max(Double(midPeak) ?? 0.0, 0.0)
        return (on * 0.158) + (off * 0.076) + (mid * 0.122)
    }
    
    // Charges for each TOU period separately
    var onPeakAmount: Double {
        let value = Double(onPeak) ?? 0.0
        return max(value, 0.0) * 0.158
    }
    
    var offPeakAmount: Double {
        let value = Double(offPeak) ?? 0.0
        return max(value, 0.0) * 0.076
    }
    
    var midPeakAmount: Double {
        let value = Double(midPeak) ?? 0.0
        return max(value, 0.0) * 0.122
    }
    
    // Tiered charges = Tier 1 + Tier 2, based on usage with a 600 kWh threshold
    var tieredCharges: Double {
        return tierOneCharges + tierTwoCharges
    }
    
    // Tier 1 rate applies for usage up to 600 kWh
    var tierOneCharges: Double {
        let usage = max(Double(totalUsage) ?? 0.0, 0.0)
        return min(usage, 600) * 0.093
    }

    // Tier 2 rate applies for usage beyond 600 kWh
    var tierTwoCharges: Double {
        let usage = max(Double(totalUsage) ?? 0.0, 0.0)
        return usage > 600 ? (usage - 600) * 0.11 : 0.0
    }
    
    // Determines consumption charges based on the selected pricing plan
    var consumptionCharges: Double {
        isTiered ? tieredCharges : touCharges
    }
    
    // Calculates the provincial rebate as 13.1% of consumption charges
    var provincialRebate: Double {
        0.131 * consumptionCharges
    }
    
    // Calculates HST as 13% of (consumption charges - provincial rebate)
    var hst: Double {
        0.13 * (consumptionCharges - provincialRebate)
    }
    
    // Calculates total regulatory charges as HST - provincial rebate
    var regulatoryCharges: Double {
        hst - provincialRebate
    }
    
    // Calculates the total bill as consumption charges + regulatory charges
    var totalBill: Double {
        consumptionCharges + regulatoryCharges
    }
}

// MARK: - Preview Provider
#Preview {
    ContentView()
}
