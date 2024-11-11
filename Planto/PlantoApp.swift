//
//  PlantoApp.swift
//  Planto
//
//  Created by Wajd on 11/11/2024.
//

import SwiftUI
import SwiftData
@main
struct PlantoApp: App {
    var body: some Scene {
        WindowGroup {
            StartApp()
            .preferredColorScheme(.dark)
        }
        .modelContainer(for: Plants.self)
    }
}
