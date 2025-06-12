//
//  ImagePrompt.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//


class ImagePrompt {
    
    private static let negatives = [
        "blurry",
        "low quality",
        "low resolution",
        "deformed",
        "distorted",
        "extra limbs",
        "missing limbs",
        "bad anatomy",
        "poorly drawn face",
        "ugly",
        "mutated",
        "disfigured",
        "wrong proportions",
        "bad hands",
        "extra fingers",
        "fused fingers",
        "watermark",
        "grainy",
        "oversaturated",
        "jpeg artifacts"
    ]
    
    private static let positives = [
        "Cyberpunk city at night, glowing neon signs, rainy streets, people with futuristic clothing",
        "Retro futuristic space station interior, 1970s design style, astronauts in vintage suits",
        "Dark gothic portrait of a noble vampire woman, pale skin, crimson eyes, black lace dress",
        "Whimsical fairytale forest with glowing mushrooms, small wooden houses, fox with a cloak reading a book",
        "Post-apocalyptic wasteland with abandoned vehicles, overgrown buildings, lone survivor in gas mask",
        "Fashion photoshoot of a modern woman in an avant-garde dress, minimalist background",
        "Modern Scandinavian house in a forest, large glass windows, minimalist design",
        "Cute anime girl with long pink hair, standing in a sunflower field",
        "Futuristic humanoid robot standing in a sleek high-tech laboratory",
    ]
    
    static func random() -> String {
        positives.randomElement()!
    }
    
    static func negative() -> String {
        negatives.joined(separator: ", ")
    }
}
