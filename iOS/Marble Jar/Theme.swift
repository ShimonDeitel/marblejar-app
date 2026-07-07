import SwiftUI

/// Unique visual identity for Marble Jar: glassy blue with warm amber flecks.
enum Theme {
    static let accent = Color(hex: "#2E6F9E")
    static let accentSecondary = Color(hex: "#E8A33D")
    static let background = Color(hex: "#F4EEE2")
    static let ink = Color(hex: "#1E2A33")

    static var titleFont: Font {
        Font.system(.largeTitle, design: .rounded).weight(.bold)
    }

    static var bodyFont: Font {
        Font.system(.body, design: .rounded)
    }

    static var cardCornerRadius: CGFloat { 18 }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
