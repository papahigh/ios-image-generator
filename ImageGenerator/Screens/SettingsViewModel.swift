//
//  UserPreferences.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import SwiftUI


class SettingsViewModel : ObservableObject, Preferences {
    
    @AppStorage("disable_safety")
    public var disableSafety: Bool = Defaults.DISABLE_SAFETY
    
    @AppStorage("reduce_memory")
    public var reduceMemory: Bool = Defaults.REDUCE_MEMORY
    
    @AppStorage("step_count")
    public var stepCount: Int = Defaults.STEP_COUNT
    
    @AppStorage("image_count")
    public var imageCount: Int = Defaults.IMAGE_COUNT
    
    @AppStorage("image_size")
    public var imageSize: Int = Defaults.IMAGE_SIZE
    
    @AppStorage("guidance_scale")
    public var guidanceScale: Double = Defaults.GUIDANCE_SCALE
    
    @AppStorage("use_negative_prompt")
    public var useNegativePrompt: Bool = Defaults.USE_NEGATIVE_PROMPT

    @AppStorage("negative_prompt_text")
    public var negativePromptText: String = Defaults.NEGATIVE_PROMPT_TEXT
    
    public var negativePrompt: String { useNegativePrompt ? negativePromptText : "" }
    
    public func resetState() {
        disableSafety = Defaults.DISABLE_SAFETY
        reduceMemory = Defaults.REDUCE_MEMORY
        stepCount = Defaults.STEP_COUNT
        imageCount = Defaults.IMAGE_COUNT
        imageSize = Defaults.IMAGE_SIZE
        guidanceScale = Defaults.GUIDANCE_SCALE
        useNegativePrompt = Defaults.USE_NEGATIVE_PROMPT
        negativePromptText = Defaults.NEGATIVE_PROMPT_TEXT
    }
    
    public struct Defaults {
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
