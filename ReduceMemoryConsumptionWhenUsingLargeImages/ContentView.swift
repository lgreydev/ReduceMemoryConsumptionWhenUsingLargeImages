//
//  ContentView.swift
//  ReduceMemoryConsumptionWhenUsingLargeImages
//
//  Created by Serhii Lukashchuk on 2025-01-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let size = CGSize(width: 150, height: 150)

        NavigationStack {
            List {
                HStack {
                    ForEach(1...4, id: \ .self) { index in
                        DownsizedImageView(image: UIImage(named: "Scr\(index)"), size: size) { image in
                            GeometryReader { geometry in
                                let containerSize = geometry.size
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: containerSize.width, height: containerSize.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .frame(height: 150)
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

struct DownsizedImageView<Content: View>: View {
    var image: UIImage?
    var size: CGSize
    
    @ViewBuilder var content: (Image) -> Content
    
    @State private var downsizedImage: Image?
    
    var body: some View {
        ZStack {
            if let downsizedImage {
                content(downsizedImage)
            } else {
                ProgressView("Loading Image...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
        .onAppear { handleImageUpdate(image) }
        .onChange(of: image) { _, newValue in
            handleImageUpdate(newValue)
        }
    }
    
    private func handleImageUpdate(_ image: UIImage?) {
        guard let image else { return }
        createDownsizedImage(from: image)
    }
    
    private func createDownsizedImage(from image: UIImage?) {
        guard let image else { return }
        let targetSize = image.size.aspectFit(size)
        
        Task.detached(priority: .high) {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let resizedImage = renderer.image { context in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            await MainActor.run {
                downsizedImage = Image(uiImage: resizedImage)
            }
        }
    }
}

extension CGSize {
    func aspectFit(_ targetSize: CGSize) -> CGSize {
        let scale = min(targetSize.width / width, targetSize.height / height)
        return CGSize(width: width * scale, height: height * scale)
    }
}
