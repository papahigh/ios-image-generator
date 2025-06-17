//
//  Tabs.swift
//  ImageGenerator
//
//  Created by Nikola P on 12.06.25.
//


enum Tabs: Int {
    case home
    case settings
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }
    
    var symbol: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gear"
        }
    }
}

