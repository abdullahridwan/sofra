//
//  LocationPreviewView.swift
//  Sofra
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
    @State private var searchText = ""
    @Binding var myFavoriteLocations: [MyFavoriteLocation]
    @Binding var mapPosition: MapCameraPosition
    @State var showFavoritesSheet = false
    @State private var locationManager = CLLocationManager()

    var searchResults: [MyFavoriteLocation] {
        guard !searchText.isEmpty else { return [] }
        let q = searchText.lowercased()
        return myFavoriteLocations.filter {
            $0.name.lowercased().contains(q) || $0.address.lowercased().contains(q)
        }
    }

    private var mapID: String {
        let favIDs = myFavoriteLocations.filter(\.isFavorited).map(\.id.uuidString).joined()
        return favIDs + searchText
    }

    var body: some View {
        ZStack {
            Map(position: $mapPosition, selection: $selection) {
                UserAnnotation()
                ForEach(searchText.isEmpty ? myFavoriteLocations : searchResults) { location in
                    Marker(location.name, coordinate: location.getCoordinate2D())
                        .tint(location.isFavorited ? SofraTheme.blue : SofraTheme.primary)
                }
            }
            .id(mapID)
            .onAppear { locationManager.requestWhenInUseAuthorization() }
            .mapControls { MapUserLocationButton() }

            FavoritesButton(showFavoritesSheet: $showFavoritesSheet, searchText: $searchText)
        }
        .safeAreaInset(edge: .bottom) {
            if let sel = selection, let item = myFavoriteLocations.first(where: { $0.id == sel }) {
                SingleLocationView(item: item)
                    .background(.thinMaterial)
            } else if !searchText.isEmpty && searchResults.isEmpty {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("No results for \"\(searchText)\"")
                            .font(SofraTheme.Typography.display(15, weight: .medium))
                            .foregroundStyle(SofraTheme.text)
                        Text("Know a halal spot we're missing?")
                            .font(SofraTheme.Typography.body(13))
                            .foregroundStyle(SofraTheme.textMuted)
                    }
                    Spacer()
                    Button(action: suggestPlace) {
                        Text("Suggest it")
                            .font(SofraTheme.Typography.label(14, weight: .semibold))
                            .foregroundStyle(SofraTheme.background)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(SofraTheme.primary)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 14)
                .background(.thinMaterial)
            } else if !searchResults.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(searchResults) { location in
                            Button(action: { selection = location.id }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(location.name)
                                        .font(SofraTheme.Typography.display(15, weight: .medium))
                                        .foregroundStyle(SofraTheme.text)
                                    Text(location.address)
                                        .font(SofraTheme.Typography.body(12))
                                        .foregroundStyle(SofraTheme.textMuted)
                                        .lineLimit(1)
                                }
                                .frame(width: 200)
                                .padding(12)
                                .background(SofraTheme.background)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: SofraTheme.text.opacity(0.1), radius: 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .background(.thinMaterial)
            }
        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = myFavoriteLocations.first(where: { $0.id == selection }) else { return }
            print(item.getCoordinate2D())
        }
        .sheet(isPresented: $showFavoritesSheet) {
            FavoritesView()
        }
    }

    func suggestPlace() {
        let subject = "Suggest a place: \(searchText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let body = "Place name: \(searchText)%0AAddress: %0AExtra info: ".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "mailto:abdullahridwan73@gmail.com?subject=\(subject)&body=\(body)") {
            UIApplication.shared.open(url)
        }
    }

    func openMaps(destinationCoordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    LocationPreviewView(myFavoriteLocations: .constant([]), mapPosition: .constant(.automatic))
}
