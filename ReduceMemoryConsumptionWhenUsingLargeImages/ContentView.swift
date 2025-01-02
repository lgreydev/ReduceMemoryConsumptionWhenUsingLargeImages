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
                        let size = CGSize(width: 150, height: 150)
                        DownsizedImageView(image: UIImage(named: "Scr\(index)"), size: size) { image in
                            image
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

struct DownsizedImageView<Content: View>: View   {
    var image: UIImage?
    var size: CGSize?
    
    // it works like AsynImage
    @ViewBuilder var content: (Image) -> Content
    
    // view Properties
    @State private var downsizedImageView: Image?
    
    var body: some View {
        ZStack {
            if let downsizedImageView {
                content(downsizedImageView)
            }
        }
        .onAppear {
            guard downsizedImageView == nil else { return }
            createDownsizedImage(image)
        }
        .onChange(of: image) { oldValue, newValue in
            guard oldValue != newValue else { return }
            // dynamic image changes
            createDownsizedImage(newValue)
            createDownsizedImage(image)
        }
    }
    
    // creating Downsized image
    private func createDownsizedImage(_ image: UIImage?) {
        
    }
}

