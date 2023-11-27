import SwiftUI

protocol CustomColorProtocol {
    var color: Color { get }
}

struct CustomColor: CustomColorProtocol {
    let lightModeHex: String
    let darkModeHex: String

    var color: Color {
        Color(hexLightMode: lightModeHex, hexDarkMode: darkModeHex)
    }
}

struct CustomFont {
    let name: String
    let size: CGFloat

    var font: Font {
        Font(UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size))
    }
}

struct CustomTheme {
    static let primary100 = CustomColor(lightModeHex: "#0077C2", darkModeHex: "#0077C2")
    static let primary200 = CustomColor(lightModeHex: "#59a5f5", darkModeHex: "#59a5f5")
    static let primary300 = CustomColor(lightModeHex: "#c8ffff", darkModeHex: "#c8ffff")
    static let accent100 = CustomColor(lightModeHex: "#00BFFF", darkModeHex: "#00BFFF")
    static let accent200 = CustomColor(lightModeHex: "#00619a", darkModeHex: "#00619a")
    static let text100 = CustomColor(lightModeHex: "#333333", darkModeHex: "#333333")
    static let text200 = CustomColor(lightModeHex: "#5c5c5c", darkModeHex: "#5c5c5c")
    static let bg100 = CustomColor(lightModeHex: "#FFFFFF", darkModeHex: "#FFFFFF")
    static let bg200 = CustomColor(lightModeHex: "#f5f5f5", darkModeHex: "#f5f5f5")
    static let bg300 = CustomColor(lightModeHex: "#cccccc", darkModeHex: "#cccccc")

    static func lightFredoka(size: CGFloat) -> CustomFont {
        CustomFont(name: "Quicksand-Light", size: size)
    }

    static func regularFredoka(size: CGFloat) -> CustomFont {
        CustomFont(name: "Quicksand-Regular", size: size)
    }

    static func mediumFredoka(size: CGFloat) -> CustomFont {
        CustomFont(name: "Quicksand-Medium", size: size)
    }

    static func semiboldFredoka(size: CGFloat) -> CustomFont {
        CustomFont(name: "Quicksand-SemiBold", size: size)
    }

    static func boldQuicksand(size: CGFloat) -> CustomFont {
        CustomFont(name: "Quicksand-Bold", size: size)
    }
}

extension Color {
    init(hexLightMode: String, hexDarkMode: String) {
        self.init(UIColor(hexLightMode: hexLightMode, hexDarkMode: hexDarkMode))
    }
}
