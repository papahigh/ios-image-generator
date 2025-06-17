//
//  ImageGeneratorApp.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

import SwiftUI
import SwiftData


@main
struct ImageGeneratorApp: App {
    
    let modelContainer: ModelContainer
    let userPreferences: SettingsViewModel
    let imageGallery: ImageGalleryViewModel

    var body: some Scene {
        WindowGroup {
            ImageGeneratorTabs()
        }
        .environmentObject(userPreferences)
        .environmentObject(imageGallery)
        .modelContainer(modelContainer)
    }
    
    init() {
        do {
            modelContainer = try createContainer()
            userPreferences = SettingsViewModel()
            imageGallery = ImageGalleryViewModel(
                imageService: LocalStableDiffusionService(preferences: userPreferences),
                modelContext: modelContainer.mainContext
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}


fileprivate func createContainer() throws -> ModelContainer {
    let schema = Schema([
        ImageModel.self,
    ])
    return try ModelContainer(
        for: schema,
        configurations: [
            ModelConfiguration(schema: schema, isStoredInMemoryOnly: false),
        ]
    )
}
