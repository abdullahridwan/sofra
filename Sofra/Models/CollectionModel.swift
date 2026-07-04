//
//  CollectionModel.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 3/30/24.
//

import Foundation
import SwiftData

@Model
class Collection {
    var name: String
    @Relationship(deleteRule: .cascade) var items: [MyFavoriteLocation] = []
    
    init(name: String, items: [MyFavoriteLocation]) {
        self.name = name
        self.items = items
    }
}
