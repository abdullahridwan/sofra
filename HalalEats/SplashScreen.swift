//
//  SplashScreen.swift
//  HalalEats
//
//  Created by Abdullah Ridwan on 4/2/24.
//

import SwiftUI
import SwiftData


extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

struct SplashScreen: View {
    @Environment(\.modelContext) var modelContext
    @State private var scale = 0.7
    @Binding var isActive: Bool
    @Binding var myFavoriteLocations: [MyFavoriteLocation]

    var body: some View {
        ZStack{
            Color(hex:"#FFFFD2")
                .ignoresSafeArea()
            Image("SplashScreen")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
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
