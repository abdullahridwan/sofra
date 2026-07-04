//
//  Theme.swift
//  HalalEats
//

import SwiftUI
import CoreText

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

enum SofraTheme {
    static let background = Color(hex: "#FFFFFF")
    static let surface = Color(hex: "#F6F4F2")
    static let border = Color(hex: "#E7E3DE")
    static let text = Color(hex: "#2B2320")
    static let textMuted = Color(hex: "#7A6F66")
    static let primary = Color(hex: "#C1502E")
    static let primaryDark = Color(hex: "#9C3F24")
    static let favorite = Color(hex: "#B5323F")

    enum Typography {
        static func display(_ size: CGFloat, weight: Font.Weight = .medium) -> Font {
            .custom("Fraunces", size: size).weight(weight)
        }

        static func body(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
            .custom("Inter", size: size).weight(weight)
        }

        static func label(_ size: CGFloat, weight: Font.Weight = .medium) -> Font {
            .custom("Inter", size: size).weight(weight)
        }
    }
}

enum FontRegistrar {
    private static var didRegister = false

    static func registerCustomFonts() {
        guard !didRegister else { return }
        didRegister = true

        for fileName in ["Fraunces-Variable", "Inter-Variable"] {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "ttf") else {
                print("Could not find font file: \(fileName)")
                continue
            }
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error) {
                print("Failed to register font \(fileName): \(String(describing: error))")
            }
        }
    }
}
