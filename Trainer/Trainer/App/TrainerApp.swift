//
//  TrainerApp.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/26/26.
//

import SwiftUI

@main
struct TrainerApp: App {
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}
