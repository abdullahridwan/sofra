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
                            .foregroundStyle(.white)
                            .shadow(color: Color.gray.opacity(0.25), radius: 10)
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                            .shadow(color: Color.red.opacity(0.2), radius: 6)
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
