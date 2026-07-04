//
//  ContentView.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var isActive = false
    @State private var myFavoriteLocations: [MyFavoriteLocation] = []

    var body: some View {
        if isActive {
            LocationPreviewView(myFavoriteLocations: $myFavoriteLocations)
        }else {
            SplashScreen(isActive: $isActive, myFavoriteLocations: $myFavoriteLocations)
        }
    }
}

#Preview {
    ContentView()
}
