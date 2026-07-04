//
//  SplashScreen.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 4/2/24.
//

import SwiftUI
import SwiftData

struct SplashScreen: View {
    @Environment(\.modelContext) var modelContext
    @State private var scale = 0.7
    @Binding var isActive: Bool
    @Binding var myFavoriteLocations: [MyFavoriteLocation]

    var body: some View {
        ZStack{
            SofraTheme.background
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Sofra")
                    .font(SofraTheme.Typography.display(56, weight: .medium))
                    .foregroundStyle(SofraTheme.text)
                Text("halal food, mapped")
                    .font(SofraTheme.Typography.label(14))
                    .foregroundStyle(SofraTheme.primary)
            }
            VStack{
                Spacer()
                Spacer()
                HStack{
                    EmojiSwitcher(emojis: ["🍛", "🍔", "🥟", "🍖", "🍕"])
                    EmojiSwitcher(emojis: ["🥟", "🌯", "🌮", "🍛", "🍤"])
                    EmojiSwitcher(emojis: ["🌮", "🥘", "🍮", "🍗", "🥙"])
                }
                Spacer()
            }
        }
        .onAppear {
            var all_locations = loadLocationsFromJSON()
            for l in all_locations {
                addObjectIfNotExist(location: l)
            }

            loadLocations()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }

    }
    
    func addObjectIfNotExist(location: MyFavoriteLocation){
        var fetchDescriptor = FetchDescriptor<MyFavoriteLocation>()
        fetchDescriptor.predicate = #Predicate { item in
            location.name == item.name
        }
        print("item is \(location.name)")
        do {
            let existingItem = try modelContext.fetch(fetchDescriptor)
            print(existingItem)
            if existingItem.first == nil {
                print("item \(location.name) doesnt exist")
                modelContext.insert(location)
            }
        } catch {
            print("SwiftData Error: \(error)")
        }
    }
    
    private func loadLocations() {
        let fetchDescriptor = FetchDescriptor<MyFavoriteLocation>()
        
        do {
            self.myFavoriteLocations = try modelContext.fetch(fetchDescriptor)
        } catch {
             // Error handling here or make the function throw
            print("Error loading the variable [myFavoriteLocations]")
        }
    }
    
    
}

#Preview{
    SplashScreen(isActive: .constant(true), myFavoriteLocations: .constant([]))
}
