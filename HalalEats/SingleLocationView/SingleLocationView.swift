//
//  SingleLocationView.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation


struct SingleLocationView: View {
    @Environment(\.modelContext) private var context
    var item: MyFavoriteLocation
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(item.name)
                            .font(Font.headline)
                        Spacer()
                        Button(action: {
                            print("In isFavorited Button")
                            print("\(item.name) is \(item.isFavorited)")
                            item.isFavorited.toggle()
                            print("\(item.name) is \(item.isFavorited)")
                            print("---")
                            //try? context.save()
                        }) {
                            Image(systemName: item.isFavorited ? "heart.fill" : "heart")
                                .foregroundColor(item.isFavorited ? .pink : .gray)
                        }
                    }
                    Text(item.address)
                        .font(Font.subheadline)
                    Button {
                        print("Directions")
                        print("\(item.name) is \(item.isFavorited)")
                        openMaps(destinationCoordinate: item.getCoordinate2D())
                        print("\(item.name) is \(item.isFavorited)")
                        print("---")

                    } label: {
                        Text("Directions")
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()
            LocationPreviewLookAroundView(selectedResult: item)
                .frame(height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.top, .horizontal])
        }
    }
//    func openTikTok() {
//        let tikTokURL = URL(string: "https://www.tiktok.com/@muslimfoodies/video/7061786483933629743?is_from_webapp=1&sender_device=pc&web_id=7349310675803719211")!
//        UIApplication.shared.open(tikTokURL, options: [:], completionHandler: nil)
//    }

    func openMaps(destinationCoordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    SingleLocationView(item:MyFavoriteLocation(name: "Bob's Burgers", address: "123 Whitehall lane", latitude: 40.853950, longitude: -73.908220, isFavorited: true))
}
