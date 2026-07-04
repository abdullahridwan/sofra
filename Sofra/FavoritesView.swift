//
//  FavoritesView.swift
//  Sofra
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
                            .font(SofraTheme.Typography.body(15))
                            .foregroundStyle(SofraTheme.textMuted)
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
                                        .foregroundColor(SofraTheme.background)
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
