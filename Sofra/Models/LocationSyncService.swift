//
//  LocationSyncService.swift
//  Sofra
//

import Foundation
import SwiftData

private struct SupabaseLocation: Decodable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, latitude, longitude
        case updatedAt = "updated_at"
    }
}

enum LocationSyncService {
    private static let supabaseURL = "https://zswxjecwcqgypcfktpdq.supabase.co"
    private static let anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpzd3hqZWN3Y3FneXBjZmt0cGRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODMxMjQyMDEsImV4cCI6MjA5ODcwMDIwMX0.qWM983SCiQVX2GeDYTQNoEWCNmgox8v4fOlB0Djnotg"
    private static let lastSyncKey = "lastSyncedAt"

    @MainActor
    static func sync(context: ModelContext) async {
        do {
            let remote = try await fetchRemote()
            upsert(remote, context: context)
            UserDefaults.standard.set(
                ISO8601DateFormatter().string(from: Date()),
                forKey: lastSyncKey
            )
        } catch {
            print("Sofra sync failed: \(error)")
        }
    }

    private static func fetchRemote() async throws -> [SupabaseLocation] {
        var urlString = "\(supabaseURL)/rest/v1/locations?select=*&order=updated_at.asc"

        if let lastSync = UserDefaults.standard.string(forKey: lastSyncKey),
           let encoded = lastSync.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString += "&updated_at=gt.\(encoded)"
        }

        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue(anonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(anonKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([SupabaseLocation].self, from: data)
    }

    @MainActor
    private static func upsert(_ remoteLocations: [SupabaseLocation], context: ModelContext) {
        guard !remoteLocations.isEmpty else { return }

        let existing = (try? context.fetch(FetchDescriptor<MyFavoriteLocation>())) ?? []
        let byRemoteId = Dictionary(
            uniqueKeysWithValues: existing.compactMap { loc -> (String, MyFavoriteLocation)? in
                guard let rid = loc.remoteId else { return nil }
                return (rid, loc)
            }
        )

        for remote in remoteLocations {
            if let local = byRemoteId[remote.id] {
                local.name = remote.name
                local.address = remote.address
                local.latitude = remote.latitude
                local.longitude = remote.longitude
            } else if let local = existing.first(where: {
                $0.remoteId == nil &&
                $0.name == remote.name &&
                $0.address == remote.address
            }) {
                // Link JSON-seeded record to its Supabase row
                local.remoteId = remote.id
                local.latitude = remote.latitude
                local.longitude = remote.longitude
            } else {
                let loc = MyFavoriteLocation(
                    name: remote.name,
                    address: remote.address,
                    latitude: remote.latitude,
                    longitude: remote.longitude,
                    isFavorited: false
                )
                loc.remoteId = remote.id
                context.insert(loc)
            }
        }
    }
}
