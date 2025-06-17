//
//  GenerateFlow.swift
//  ImageGenerator
//
//  Created by Nikola P on 16.06.25.
//

import SwiftUI


struct GenerateFlow: View {
    
    let sample: String
    let onSubmit: (String) async -> Void
    let onCancel: () -> Void
    
    @State private var prompt = ""
    @State private var inProgress = false
    

    var body: some View {
        NavigationStack {
            VStack {
                StyledTextArea(sample, value: $prompt, autofocus: true)
                Spacer()
                PrimaryButton("Generate") {
                    inProgress = true
                }
            }
            .navigationDestination(isPresented: $inProgress) {
                WorkInProgress(
                    prompt: prompt.isEmpty ? sample : prompt,
                    onSubmit: onSubmit,
                    onCancel: onCancel
                )
            }
            .navigationTitle("Describe your image")
            .withCancel(onCancel)
            .padding()
        }
    }
    
    
    struct WorkInProgress: View {
        let prompt: String
        let onSubmit: (String) async -> Void
        let onCancel: () -> Void
        
        var body: some View {
            VStack {
                ProgressView()
            }
            .task {
                await onSubmit(prompt)
            }
            .navigationTitle("Generating...")
            .withCancel(onCancel)
        }
    }
}

fileprivate extension View {
    func withCancel(_ onCancel: @escaping () -> Void) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel", systemImage: "xmark", role: .cancel) {
                    onCancel()
                }
            }
        }
    }
}


#Preview {
    GenerateFlow(
        sample: ImagePrompt.random(),
        onSubmit: { it in print(it)},
        onCancel: { print("Cancelled") },
    )
}
