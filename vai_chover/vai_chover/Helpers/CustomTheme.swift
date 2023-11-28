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

struct CustomTheme {
    static let primary100 = CustomColor(lightModeHex: "#0077C2", darkModeHex: "#0077C2")
    static let primary200 = CustomColor(lightModeHex: "#59a5f5", darkModeHex: "#59a5f5")
    static let primary300 = CustomColor(lightModeHex: "#c8ffff", darkModeHex: "#c8ffff")
    static let accent100 = CustomColor(lightModeHex: "#00BFFF", darkModeHex: "#00BFFF")
    static let accent200 = CustomColor(lightModeHex: "#00619a", darkModeHex: "#00619a")
    static let text100 = CustomColor(lightModeHex: "#333333", darkModeHex: "#FFFFFF")
    static let text200 = CustomColor(lightModeHex: "#5c5c5c", darkModeHex: "#CCCCCC")
    static let bg100 = CustomColor(lightModeHex: "#FFFFFF", darkModeHex: "#FFFFFF")
    static let bg200 = CustomColor(lightModeHex: "#f5f5f5", darkModeHex: "#f5f5f5")
    static let bg300 = CustomColor(lightModeHex: "#cccccc", darkModeHex: "#cccccc")

    static func fontBlacktInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Black", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontBoldInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Bold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontExtraBoldInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontExtraLightInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontLightInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Light", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontMediumInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Medium", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontRegularInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Regular", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontSemiBoldInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size))
    }
    
    static func fontThinInter(size: CGFloat) -> Font {
        return Font(UIFont(name: "Inter-Thin", size: size) ?? UIFont.systemFont(ofSize: size))
    }
}

extension Color {
    init(hexLightMode: String, hexDarkMode: String) {
        self.init(UIColor(hexLightMode: hexLightMode, hexDarkMode: hexDarkMode))
    }
}
