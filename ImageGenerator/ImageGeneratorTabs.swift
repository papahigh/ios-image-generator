//
//  ImageGeneratorTabs.swift
//  ImageGenerator
//
//  Created by Nikola P on 13.06.25.
//

import SwiftUI


struct ImageGeneratorTabs: View {
    
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(Tabs.home.name, systemImage: Tabs.home.symbol, value: Tabs.home) {
                ImageGalleryScreen()
            }
            Tab(Tabs.settings.name, systemImage: Tabs.settings.symbol, value: Tabs.settings) {
                SettingsScreen()
            }
        }
    }
}
