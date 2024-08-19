//
//  LocationPreviewView.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 4/1/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct LocationPreviewView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selection: UUID?
    @State private var isSaved = false
    @Binding var myFavoriteLocations: [MyFavoriteLocation]
    @State var showFavoritesSheet: Bool = false
    
    var body: some View {
        ZStack{
            Map(selection: $selection) {
                ForEach(myFavoriteLocations) { location in
                    Marker(location.name, coordinate: location.getCoordinate2D())
                        .tint(location.isFavorited ? .red : .orange)
                        
                }
            }
            FavoritesButton(showFavoritesSheet: $showFavoritesSheet)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selection {
                        if let item = myFavoriteLocations.first(where: { $0.id == selection }) {
                                SingleLocationView(item: item)
                        }
                    }
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
//        .onAppear {
//            myFavoriteLocations = loadLocationsFromJSON()
//            for l in myFavoriteLocations {
//                modelContext.insert(l)
//            }
//        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = myFavoriteLocations.first(where: { $0.id == selection }) else { return }
            print(item.getCoordinate2D())
        }
        .sheet(isPresented: $showFavoritesSheet, content: {
            FavoritesView()
        })
    }
    
    func openMaps(destinationCoordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview{
    LocationPreviewView(myFavoriteLocations: .constant([]))
}
