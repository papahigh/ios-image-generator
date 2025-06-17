//
//  ImageView.swift
//  ImageGenerator
//
//  Created by Nikola P on 16.06.25.
//


import SwiftUI


struct ImageDetails: View {
    
    let image: ImageModel

    var body: some View {
        List {
            imageView
            imageInfo
            shareButton
        }
        .navigationTitle("Image Details")
    }
    
    //
    // MARK: private
    
    @ViewBuilder
    private var imageView: some View {
        if let uiImage = image.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .padding(.vertical)
                .scaledToFit()
        }
    }
    
    private var imageInfo: some View {
        Section("Prompt") {
            Text(image.prompt)
        }
    }
    
    @ViewBuilder
    private var shareButton: some View {
        if let uiImage = image.uiImage {
            Section {
                ShareLink(
                    item: Image(uiImage: uiImage),
                    preview:
                    SharePreview("Generated Image", image: Image(uiImage: uiImage))
                )
            }
         }
    }
}

