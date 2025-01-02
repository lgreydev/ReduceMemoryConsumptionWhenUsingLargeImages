//
//  ContentView.swift
//  ReduceMemoryConsumptionWhenUsingLargeImages
//
//  Created by Serhii Lukashchuk on 2025-01-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    ForEach(1...3, id: \.self) { index in
                        if let image = UIImage(named: "Scr\(index)") {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Downsized Images")
        }
    }
}

#Preview {
    ContentView()
}
