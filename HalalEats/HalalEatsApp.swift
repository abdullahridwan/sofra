//
//  HalalEatsApp.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import SwiftUI
import SwiftData

@main
struct HalalEatsApp: App {
    let modelContainer: ModelContainer
    init(){
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
