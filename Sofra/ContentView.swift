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
    @State private var mapPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.730, longitude: -73.985),
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    ))

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
