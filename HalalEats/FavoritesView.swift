//
//  FavoritesView.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 4/1/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(filter: #Predicate<MyFavoriteLocation> { location in
        location.isFavorited == true
    })
    var favorites: [MyFavoriteLocation]
    
    var body: some View {
        NavigationStack{
            VStack{
                if (favorites.count == 0){
                    VStack{
                        Spacer()
                        Text("Looking empty. Favorite some places!")
                        Spacer()
                    }
                }else{
                    List {
                        ForEach(favorites) { item in
                            SingleLocationView(item: item)
                                .buttonStyle(.borderless)
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 10)
                                        .background(.clear)
                                        .foregroundColor(.white)
                                        .padding(
                                            EdgeInsets(
                                                top: 13,
                                                leading: 10,
                                                bottom: 2,
                                                trailing: 10
                                            )
                                        )
                                        .shadow(color: Color.gray.opacity(0.25), radius: 10)
                                )
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
