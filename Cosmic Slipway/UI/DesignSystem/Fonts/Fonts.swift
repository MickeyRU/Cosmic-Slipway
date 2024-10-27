import UIKit
import SwiftUI

enum Fonts: String {
    case ebFigtree = "Figtree-ExtraBold"
    case rFigtree = "Figtree-Regular"
}

enum FontSize: CGFloat {
    case size10 = 10
    case size12 = 12
    case size16 = 16
    case size18 = 18
    case size24 = 24
}

struct AppFonts {
    static func uiKitFont(for font: Fonts, size: FontSize) -> UIFont? {
        return UIFont(name: font.rawValue, size: size.rawValue)
    }

    static func swiftUIFont(for font: Fonts, size: FontSize) -> Font {
        return Font.custom(font.rawValue, size: size.rawValue)
    }
    
    // Статические свойства для UIKit
    static var figtreeExBold12: UIFont? { return uiKitFont(for: .ebFigtree, size: .size12) }
    static var figtreeExBold16: UIFont? { return uiKitFont(for: .ebFigtree, size: .size16) }
    static var figtreeExBold18: UIFont? { return uiKitFont(for: .ebFigtree, size: .size18) }
    static var figtreeExBold24: UIFont? { return uiKitFont(for: .ebFigtree, size: .size24) }
    static var figtreeRegular10: UIFont? { return uiKitFont(for: .rFigtree, size: .size10) }
    static var figtreeRegular12: UIFont? { return uiKitFont(for: .rFigtree, size: .size12) }
    
    // Статические свойства для SwiftUI
    static var figtreeExBold12SwiftUI: Font { return swiftUIFont(for: .ebFigtree, size: .size12) }
    static var figtreeExBold16SwiftUI: Font { return swiftUIFont(for: .ebFigtree, size: .size16) }
    static var figtreeExBold18SwiftUI: Font { return swiftUIFont(for: .ebFigtree, size: .size18) }
    static var figtreeExBold24SwiftUI: Font { return swiftUIFont(for: .ebFigtree, size: .size24) }
    static var figtreeRegular10SwiftUI: Font { return swiftUIFont(for: .rFigtree, size: .size10) }
    static var figtreeRegular12SwiftUI: Font { return swiftUIFont(for: .rFigtree, size: .size12) }
}
