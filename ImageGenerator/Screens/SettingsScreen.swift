//
//  SettingsScreen.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//

import SwiftUI


struct SettingsScreen: View {
    
    @EnvironmentObject var viewModel: SettingsViewModel

    @FocusState private var focusState: FocusedField?
    
    enum FocusedField {
        case disableSafety
        case reduceMemory
        case imageCount
        case imageSize
        case stepCount
        case guidanceScale
        case useNegativePrompt
        case negativePromptText
    }
   
    var body: some View {
        NavigationStack {
            Form {
                generalSection
                negativePromptSection
                Section("Pipeline Settings") {
                    imageCountInput
                    imageSizeInput
                    stepCountInput
                    guidanceScaleInput
                }
                resetSettingsButton
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                ToolbarItem(placement: .keyboard) {
                    Button {
                        focusState = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
    
    //
    // MARK: private
    
    private var generalSection: some View {
        Section("General") {
            Toggle(
                isOn: $viewModel.disableSafety,
                label: { Text("Disable Safety") },
            ).focused($focusState, equals: .disableSafety)
            Toggle(
                isOn: $viewModel.reduceMemory,
                label: { Text("Reduce Memory") },
            ).focused($focusState, equals: .reduceMemory)
        }
    }
    
    private var negativePromptSection: some View {
        Section {
            Toggle(
                isOn: $viewModel.useNegativePrompt,
                label: { Text("Use negative prompt") },
            ).focused($focusState, equals: .useNegativePrompt)
            TextField("Negative Prompt", text: $viewModel.negativePromptText, axis: .vertical)
                .foregroundStyle(
                    !viewModel.useNegativePrompt ? .secondary : .primary)
                .focused($focusState, equals: .negativePromptText)
                .disabled(!viewModel.useNegativePrompt)

        } header: {
            Text("Negative Prompt")
        } footer: {
            Text("Negative text prompt to guide sampling")
        }
    }

    private var imageCountInput: some View {
        VStack(alignment: .leading) {
            LabeledContent {
                TextField("Image Count", value: $viewModel.imageCount, format: .number)
                    .focused($focusState, equals: .imageCount)
                    .keyboardType(.numberPad)
                    .disabled(true)
            } label: {
                Text("Image Count")
                    .frame(width: 120, alignment: .leading)
            }
            Text("Number of images to generate")
                .fontWeight(.thin)
                .font(.caption)
        }
    }
    
    
    private var imageSizeInput: some View {
        VStack(alignment: .leading) {
            LabeledContent {
                TextField("Image Size", value: $viewModel.imageSize, format: .number)
                    .focused($focusState, equals: .imageSize)
                    .keyboardType(.numberPad)
            } label: {
                Text("Image Size")
                    .frame(width: 120, alignment: .leading)
            }
            Text("Desired height and width of the generated image")
                .fontWeight(.thin)
                .font(.caption)
        }
    }
    
    private var stepCountInput: some View {
        VStack(alignment: .leading) {
            LabeledContent {
                TextField("Step Count", value: $viewModel.stepCount, format: .number)
                    .focused($focusState, equals: .stepCount)
                    .keyboardType(.numberPad)
            } label: {
                Text("Step Count")
                    .frame(width: 120, alignment: .leading)
            }
            Text("Number of inference steps to perform")
                .fontWeight(.thin)
                .font(.caption)
        }
    }
    
    private var guidanceScaleInput: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Guidance Scale")
                Text("\(viewModel.guidanceScale, specifier: "%.2f")")
                    .fontWeight(.thin)
            }
            Slider(value: $viewModel.guidanceScale, in: 0...20, step: 0.5) {
                Text("Guidance Scale")
            } minimumValueLabel: {
                Text("0").fontWeight(.thin)
            } maximumValueLabel: {
                Text("20").fontWeight(.thin)
            }
            .focused($focusState, equals: .guidanceScale)
            Text("Controls the influence of the text prompt on sampling process (0=random images)")
                .fontWeight(.thin)
                .font(.caption)
        }
    }
 
    private var resetSettingsButton: some View {
        HStack {
            Spacer()
            Button("Reset Settings", role: .destructive){
                viewModel.resetState()
            }
            Spacer()
        }
    }
}


#Preview {
    SettingsScreen()
        .environmentObject(SettingsViewModel())
}
