//
//  ImageModel.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

import Foundation
import SwiftData


@Model
final class ImageModel {

    @Attribute(.externalStorage)
    var image: Data?
    var prompt: String
    var negativePrompt: String
    var createdAt: Date
    
    init(image: Data? = nil, prompt: String, negativePrompt: String, createdAt: Date) {
        self.image = image
        self.prompt = prompt
        self.negativePrompt = negativePrompt
        self.createdAt = createdAt
    }
}
