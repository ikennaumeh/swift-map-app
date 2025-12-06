//
//  swift_map_appApp.swift
//  swift-map-app
//
//  Created by Ikenna Umeh on 04/12/2025.
//

import SwiftUI

@main
struct swift_map_appApp: App {
    @StateObject private var vm  = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vm)
        }
    }
} 
