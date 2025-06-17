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


struct Artifacts {
    let images: [CGImage?]
    let prompt: String
    let negativePrompt: String
}


protocol ImageService {
    func generateImages(prompt: String) throws -> Artifacts
}


class LocalStableDiffusionService: ImageService {
    
    private let resourcesURL: URL
    private let computeUnits: MLComputeUnits
    private let preferences: Preferences
    
    init(
        resourcesURL: URL = Bundle.main.resourceURL!,
        computeUnits: MLComputeUnits = .cpuAndNeuralEngine,
        preferences: Preferences
    ) {
        self.resourcesURL = resourcesURL
        self.computeUnits = computeUnits
        self.preferences = preferences
    }

    public func generateImages(prompt: String) throws -> Artifacts {
        let config = getPipelineConfig(of: prompt)
        let images = try getStableDiffusionPipeline().generateImages(configuration: config)
        return Artifacts(images: images, prompt: config.prompt, negativePrompt: config.negativePrompt)
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
        config.targetSize = preferences.imageSize.toFloat32()
        config.originalSize = preferences.imageSize.toFloat32()
        config.guidanceScale = preferences.guidanceScale.toFloat32()
        return config
    }
}

fileprivate extension Int {
    func toFloat32() -> Float32 { Float32(self)}
}

fileprivate extension Double {
    func toFloat32() -> Float32 { Float32(self) }
}
