//
//  ImageGalleryScreen.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import SwiftUI
import SwiftData


struct ImageGalleryScreen: View {
        
    @EnvironmentObject
    private var viewModel: ImageGalleryViewModel
    
    @Query(sort: \ImageModel.createdAt, order: .reverse)
    private var images: [ImageModel] = []
    

    var body: some View {
        NavigationStack {
            Group {
                if images.isEmpty {
                    noImagesFound
                } else {
                    imagesList
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Generate", systemImage: "wand.and.sparkles.inverse") {
                        viewModel.showSheet = true
                    }
                }
            }
            .navigationBarTitle("Image Generator", displayMode: .inline)
            .navigationDestination(for: ImageModel.self) { image in
                ImageDetails(image: image)
            }
        }
        .sheet(isPresented: $viewModel.showSheet) {
            GenerateFlow(
                sample: ImagePrompt.random(),
                onSubmit: { await viewModel.generateImage(prompt: $0) },
                onCancel: { viewModel.onCancel() }
            )
        }
        .alert("Error",
               isPresented: $viewModel.showError,
               actions: { Button("OK", role: .cancel) {} },
               message: { Text("Error occurred while generating image. Please try again later.") }
        )
    }
    
    //
    // MARK: private
    
    private var noImagesFound: some View {
        VStack {
            Image(systemName:"photo.on.rectangle.angled.fill")
                .resizable()
                .scaledToFit()
            Text("No images found")
        }
        .padding(Spacing.xxxl)
        .foregroundStyle(.tertiary)
        .font(.headline)
    }
    
    private var imagesList: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.md) {
                ForEach(images, id: \.id) { it in
                    if let uiImage = it.uiImage {
                        NavigationLink(
                            value: it,
                            label: { Thumbnail(uiImage: uiImage) }
                        )
                    }
                }
            }.padding()
        }
    }
    
    private struct Thumbnail: View {
        let uiImage: UIImage
        
        var body: some View {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: Spacing.md))
                .shadow(radius: Spacing.xs)
        }
    }
}
