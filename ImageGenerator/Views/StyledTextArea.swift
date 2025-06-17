//
//  StyledTextArea.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

import SwiftUI


struct StyledTextArea : View {
    
    let text: String
    let value: Binding<String>
    let autofocus: Bool
    let minLines: Int
    
    @FocusState
    private var isFocused: Bool
    
    init(_ text: String, value: Binding<String>, autofocus: Bool = false, minLines: Int = 4) {
        self.text = text
        self.value = value
        self.autofocus = autofocus
        self.minLines = minLines
    }
    
    var body: some View {
        TextField(text, text: value, axis: .vertical)
            .font(.title2)
            .textFieldStyle(.plain)
            .lineLimit(minLines...)
            .focused($isFocused)
            .onAppear {
                if autofocus {
                    isFocused = true
                }
            }
    }
}
