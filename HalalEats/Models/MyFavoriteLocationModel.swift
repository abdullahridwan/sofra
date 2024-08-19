//
//  MyFavoriteLocationModel.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 3/30/24.
//
import Foundation
import MapKit
import SwiftData
import SwiftUI


// Create an entity for a place
@Model
class MyFavoriteLocation: Identifiable, Equatable, Codable {
    @Attribute(.unique) var id : UUID
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var isFavorited: Bool
    static func == (lhs: MyFavoriteLocation, rhs: MyFavoriteLocation) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(name: String, address: String, latitude: Double, longitude: Double, isFavorited: Bool) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorited = isFavorited
    }
    enum CodingKeys: String, CodingKey {
        case name, address, latitude, longitude
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let address = try container.decode(String.self, forKey: .address)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)

        self.init(name: name, address: address, latitude: latitude, longitude: longitude, isFavorited: false)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    func getCoordinate2D() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}


func loadLocationsFromJSON() -> [MyFavoriteLocation]{
    if let url = Bundle.main.url(forResource: "locations", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            var myFavoriteLocations = try decoder.decode([LocationData].self, from: data).map { locationData in
                return MyFavoriteLocation(name: locationData.name,address: locationData.address, latitude: locationData.latitude, longitude: locationData.longitude, isFavorited: false)
            }
            return myFavoriteLocations
        } catch {
            print("Error loading locations: \(error.localizedDescription)")
        }
    }
    return []
}

struct LocationData: Decodable {
    let name: String
    let address: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
