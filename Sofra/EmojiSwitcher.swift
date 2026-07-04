//
//  EmojiSwitcher.swift
//  Sofra
//
//  Created by Abdullah Ridwan on 4/5/24.
//

import SwiftUI

struct EmojiSwitcher: View {
    @State private var isHamburger = true
    
    @State var emojis: [String]
    
    var body: some View {
        VStack {
            if isHamburger {
                Text(emojis[0])
                    .font(.system(size: 30))
                    .scaleEffect(isHamburger ? 1.0 : 0.1)
                    .opacity(isHamburger ? 1.0 : 0.0)
                    .animation(.spring(duration: 0.5))
            } else {
                Text(emojis[1])
                    .font(.system(size: 30))
                    .scaleEffect(isHamburger ? 0.1 : 1.0)
                    .opacity(isHamburger ? 0.0 : 1.0)
                    .animation(.spring(duration: 0.5))
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation {
                    self.isHamburger.toggle()
                }
            }
        }
    }
}

#Preview {
    EmojiSwitcher(emojis: ["🍔", "🌯"])
}
