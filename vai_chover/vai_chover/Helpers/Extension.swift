import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension UIColor {
    convenience init(hexLightMode: String, hexDarkMode: String) {
        let lightColor = UIColor(hex: hexLightMode)
        let darkColor = UIColor(hex: hexDarkMode)
        self.init(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        })
    }

    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
