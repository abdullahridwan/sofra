//
//  FavoritesButton.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 4/2/24.
//

import SwiftUI

struct FavoritesButton: View {
    @Binding var showFavoritesSheet: Bool
    @Binding var searchText: String
    @State private var isSearching = false

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                // Wordmark
                Text("Sofra")
                    .font(SofraTheme.Typography.display(22, weight: .medium))
                    .foregroundStyle(SofraTheme.text)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(SofraTheme.background)
                    .clipShape(Capsule())
                    .shadow(color: SofraTheme.text.opacity(0.15), radius: 10)

                if isSearching {
                    // Expanded search bar
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(SofraTheme.textMuted)
                            .font(.system(size: 14))
                        TextField("Search...", text: $searchText)
                            .font(SofraTheme.Typography.body(15))
                            .foregroundStyle(SofraTheme.text)
                            .autocorrectionDisabled()
                        Button(action: {
                            searchText = ""
                            withAnimation(.spring(response: 0.3)) { isSearching = false }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(SofraTheme.textMuted)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(SofraTheme.background)
                    .clipShape(Capsule())
                    .shadow(color: SofraTheme.text.opacity(0.15), radius: 10)
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                } else {
                    Spacer()

                    // Search icon bubble
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) { isSearching = true }
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(SofraTheme.background)
                                .shadow(color: SofraTheme.text.opacity(0.15), radius: 10)
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(SofraTheme.text)
                                .font(.system(size: 16))
                        }
                    }
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                }

                // Bookmark bubble
                Button(action: { showFavoritesSheet.toggle() }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(SofraTheme.background)
                            .shadow(color: SofraTheme.text.opacity(0.15), radius: 10)
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(SofraTheme.blue)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    FavoritesButton(showFavoritesSheet: .constant(false), searchText: .constant(""))
}
