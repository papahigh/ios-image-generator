//
//  UserPreferences.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import SwiftUI


class SettingsViewModel : ObservableObject {
    
    @AppStorage("disable_safety")
    var disableSafety: Bool = Defaults.DISABLE_SAFETY
    
    @AppStorage("reduce_memory")
    var reduceMemory: Bool = Defaults.REDUCE_MEMORY
    
    @AppStorage("step_count")
    var stepCount: Int = Defaults.STEP_COUNT
    
    @AppStorage("image_count")
    var imageCount: Int = Defaults.IMAGE_COUNT
    
    @AppStorage("image_size")
    var imageSize: Int = Defaults.IMAGE_SIZE
    
    var imageSizeValue: Float32 { Float32(imageSize) }
    
    @AppStorage("guidance_scale")
    var guidanceScale: Double = Defaults.GUIDANCE_SCALE
    
    var guidanceScaleValue: Float { Float(guidanceScale) }
    
    @AppStorage("use_negative_prompt")
    var useNegativePrompt: Bool = Defaults.USE_NEGATIVE_PROMPT
    
    @AppStorage("negative_prompt_text")
    var negativePromptText: String = Defaults.NEGATIVE_PROMPT_TEXT
    
    var negativePrompt: String { useNegativePrompt ? negativePromptText : "" }
    
    func resetState() {
        disableSafety = Defaults.DISABLE_SAFETY
        reduceMemory = Defaults.REDUCE_MEMORY
        stepCount = Defaults.STEP_COUNT
        imageCount = Defaults.IMAGE_COUNT
        imageSize = Defaults.IMAGE_SIZE
        guidanceScale = Defaults.GUIDANCE_SCALE
        useNegativePrompt = Defaults.USE_NEGATIVE_PROMPT
        negativePromptText = Defaults.NEGATIVE_PROMPT_TEXT
    }
    
    private struct Defaults {
        static let DISABLE_SAFETY: Bool = true
        static let REDUCE_MEMORY: Bool = true
        static let STEP_COUNT: Int = 50
        static let GUIDANCE_SCALE: Double = 7.5
        static let IMAGE_COUNT: Int = 1
        static let IMAGE_SIZE: Int = 512
        static let USE_NEGATIVE_PROMPT: Bool = true
        static var NEGATIVE_PROMPT_TEXT: String { ImagePrompt.negative() }
    }
}
