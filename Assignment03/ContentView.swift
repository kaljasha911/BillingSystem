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
    
    var body: some View {
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
