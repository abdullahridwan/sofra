//
//  PreloadContainer.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import Foundation
import SwiftData
import SwiftUI
// NOT WORKING
//
//@MainActor
//let container: ModelContainer = {
//    @AppStorage("sampleDataAdded") var sampleDataAdded: Bool = false
//    do {
//        
//        let container = try ModelContainer(for: MyFavoriteLocation.self, Collection.self)
//        if sampleDataAdded { return container }
//        
//        var itemFetchDescriptor = FetchDescriptor<MyFavoriteLocation>()
//        itemFetchDescriptor.fetchLimit = 1
//        
//        var collectionFetchDescriptor = FetchDescriptor<Collection>()
//        collectionFetchDescriptor.fetchLimit = 1
//        
//        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
//        guard try container.mainContext.fetch(collectionFetchDescriptor).count == 0 else { return container }
//        
//        let collection = Collection(name: "Locations", items: [])
//        container.mainContext.insert(collection)
//        
//        let items = loadLocationsFromJSON()
//        
//        for item in items {
//            //item.collections?.append(collection)
//            container.mainContext.insert(item)
//        }
//        sampleDataAdded = true
//        
//        return container
//    } catch {
//        fatalError("Failed to create container")
//    }
//}()
