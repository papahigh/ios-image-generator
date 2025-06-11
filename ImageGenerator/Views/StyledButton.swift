//
//  StyledButton.swift
//  ImageGenerator
//
//  Created by Nikola P on 11.06.25.
//

import SwiftUI


struct PrimaryButton: View {
    
    private let label: String
    private let disabled: Bool
    private let onClick: () -> Void
    
    init(_ label: String, disabled: Bool = false, onClick: @escaping () -> Void) {
        self.label = label
        self.disabled = disabled
        self.onClick = onClick
    }
    
    var body: some View {
        Button(action: onClick) {
            PrimaryButtonLabel(label: label)
        }.disabled(disabled)
    }
}

fileprivate struct PrimaryButtonLabel: View {
    var label: String
    var body: some View {
        Text(label)
            .padding()
            .frame(maxWidth: .infinity)
            .font(.headline)
            .foregroundColor(.white)
            .background(Colors.primary)
            .cornerRadius(Spacing.cornerRadius)
    }
}


#Preview {
    PrimaryButton("Test") {
        print("click")
    }.padding()
}

