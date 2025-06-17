//
//  Preferences.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//


protocol Preferences {
    var disableSafety: Bool { get }
    var reduceMemory: Bool { get }
    var stepCount: Int { get }
    var imageCount: Int { get }
    var imageSize: Int { get }
    var guidanceScale: Double { get }
    var negativePrompt: String { get }
}
