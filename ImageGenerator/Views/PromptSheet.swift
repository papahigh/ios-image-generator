//
//  ImagePrompt.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

import SwiftUI


struct PromptSheet : View {
    
    let prompt: String
    let onSubmit: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var value = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                StyledTextArea(prompt, value: $value, autofocus: true)
                Spacer()
                PrimaryButton("Generate") {
                    doSubmit()
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Dismiss", systemImage: "xmark") { dismiss() }
                }
            }
            .navigationTitle(Text("Describe your image"))
            .padding()
        }
    }
    
    private func doSubmit() {
        onSubmit(value.isEmpty ? prompt : value)
        dismiss()
    }
}


#Preview {
    PromptSheet(
        prompt: ImagePrompt.random(),
        onSubmit: { it in print(it) }
    )
}
