//
//  ContentView.swift
//  ReduceMemoryConsumptionWhenUsingLargeImages
//
//  Created by Serhii Lukashchuk on 2025-01-02.
//

import SwiftUI

struct ContentView: View {
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
