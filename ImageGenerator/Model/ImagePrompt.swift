//
//  ImagePrompt.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

//import ImagePlayground

class ImagePrompt {
    
    private static let prompts: [String] = [
        "A cat sitting on a couch",
        "A sunset over the ocean",
        "A person running on a treadmill",
        "A stack of books",
        "A smiling face",
        "A cityscape at night",
        "A delicious meal",
        "A beautiful garden",
        "A majestic mountain range",
    ]
    
    static func random() -> String {
        return prompts[Int.random(in: 0..<prompts.count)]
    }
}
