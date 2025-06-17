//
//  ImageGalleryViewModel.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import SwiftUI
import SwiftData
import os


class ImageGalleryViewModel : ObservableObject {
    
    private let log = Logger(subsystem: "io.papahigh.ImageGenerator", category: "Service")
    
    private let imageService: ImageService
    private let modelContext: ModelContext
    
    @Published var showSheet: Bool = false
    @Published var showError: Bool = false
    
    init(imageService: ImageService, modelContext: ModelContext) {
        self.imageService = imageService
        self.modelContext = modelContext
    }
        
    func generateImage(prompt: String) async {
        do {
            log.info("Generating image...")
            let artifacts = try imageService.generateImages(prompt: prompt)
            try Task.checkCancellation()
            log.info("Image generation done")
            if let firstImage = artifacts.images.first,
               let pngData = firstImage?.pngData(){
                let model = ImageModel(
                    image: pngData,
                    prompt: artifacts.prompt,
                    negativePrompt: artifacts.negativePrompt,
                    createdAt: Date(),
                )
                modelContext.insert(model)
                try! modelContext.save()
                log.info("Image model saved")
            }
        } catch {
            log.error("Image generation failed: \(error.localizedDescription)")
            await MainActor.run { showError = true }
        }
        await MainActor.run { showSheet = false }
    }
    
    @MainActor
    func onCancel() {
        showSheet = false
    }
}


extension ImageModel {
    var uiImage: UIImage? {
        if let image {
            UIImage(data: image)
        } else {
            nil
        }
    }
}

extension CGImage {
    func pngData() -> Data? {
        return UIImage(cgImage: self).pngData()
    }
}
