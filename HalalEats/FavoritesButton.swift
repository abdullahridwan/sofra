//
//  FavoritesButton.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 4/2/24.
//

import SwiftUI

struct FavoritesButton: View {
    @Binding var showFavoritesSheet: Bool
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    showFavoritesSheet.toggle()
                }, label: {
                    ZStack{
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(SofraTheme.background)
                            .shadow(color: SofraTheme.text.opacity(0.15), radius: 10)
                        Image(systemName: "heart.fill")
                            .foregroundColor(SofraTheme.favorite)
                            .font(.system(size: 20))
                            .padding()
                    }
                })
            }
            Spacer()
        }    }
}

#Preview {
    FavoritesButton(showFavoritesSheet: .constant(true))
}
