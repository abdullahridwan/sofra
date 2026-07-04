//
//  ContentView.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var isActive = false
    @State private var myFavoriteLocations: [MyFavoriteLocation] = []
    @State private var mapPosition: MapCameraPosition = .automatic

    var body: some View {
        if isActive {
            LocationPreviewView(myFavoriteLocations: $myFavoriteLocations, mapPosition: $mapPosition)
        } else {
            SplashScreen(isActive: $isActive, myFavoriteLocations: $myFavoriteLocations)
        }
    }
}

#Preview {
    ContentView()
}
