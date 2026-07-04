//
//  SofraApp.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import SwiftUI
import SwiftData

@main
struct SofraApp: App {
    let modelContainer: ModelContainer
    init(){
        FontRegistrar.registerCustomFonts()
        do {
            modelContainer = try ModelContainer(for: MyFavoriteLocation.self)
        }
        catch {
            fatalError("Error initializing Model Container")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [MyFavoriteLocation.self], isAutosaveEnabled: true)

        }
    }
}
