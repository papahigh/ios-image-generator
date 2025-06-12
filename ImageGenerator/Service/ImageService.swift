//
//  ImageService.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import CoreML
import Foundation
import CoreGraphics
import StableDiffusion


protocol ImageService {
    func generateImage(prompt: String) throws -> CGImage?
}


class LocalStableDiffusionService: ImageService {
    
    private let resourcesURL: URL
    private let computeUnits: MLComputeUnits
    private let preferences: SettingsViewModel
    
    init(
        resourcesURL: URL = Bundle.main.resourceURL!,
        computeUnits: MLComputeUnits = .cpuAndNeuralEngine,
        preferences: SettingsViewModel
    ) {
        self.resourcesURL = resourcesURL
        self.computeUnits = computeUnits
        self.preferences = preferences
    }
    
    func generateImage(prompt: String) throws -> CGImage? {
        let pipeline = try getStableDiffusionPipeline()
        let result = try pipeline.generateImages(
            configuration: getPipelineConfig(of: prompt)
        )
        return result.first!
    }
    
    private func getStableDiffusionPipeline() throws -> StableDiffusionPipeline {
        let pipeline = try StableDiffusionPipeline(
            resourcesAt: resourcesURL,
            controlNet: [],
            configuration: getModelConfig(),
            disableSafety: preferences.disableSafety,
            reduceMemory: preferences.reduceMemory,
        )
        try pipeline.loadResources()
        return pipeline
    }
    
    private func getModelConfig() -> MLModelConfiguration {
        let config = MLModelConfiguration()
        config.computeUnits = computeUnits
        return config
    }
    
    private func getPipelineConfig(of prompt: String) -> StableDiffusionPipeline.Configuration {
        var config = StableDiffusionPipeline.Configuration(prompt: prompt)
        config.disableSafety = preferences.disableSafety
        config.negativePrompt = preferences.negativePrompt
        config.seed = UInt32.random(in: 0..<UInt32.max)
        config.stepCount = preferences.stepCount
        config.imageCount = preferences.imageCount
        config.targetSize = preferences.imageSizeValue
        config.originalSize = preferences.imageSizeValue
        config.guidanceScale = preferences.guidanceScaleValue
        return config
    }
}
