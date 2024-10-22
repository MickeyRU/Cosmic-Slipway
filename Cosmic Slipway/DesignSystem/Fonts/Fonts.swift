import UIKit
import SwiftUI

struct Fonts {
    static let ebFigtree = "Figtree-ExtraBold"
    static let rFigtree = "Figtree-Regular"
}

enum AppFonts {
    case figtreeExBold12
    case figtreeExBold16
    case figtreeExBold18
    case figtreeExBold24
    case figtreeRegular10
    case figtreeRegular12
    
    func uiKitFont() -> UIFont {
        switch self {
        case .figtreeExBold12:
            return UIFont(name: Fonts.ebFigtree, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
        case .figtreeExBold16:
            return UIFont(name: Fonts.ebFigtree, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        case .figtreeExBold18:
            return UIFont(name: Fonts.ebFigtree, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        case .figtreeExBold24:
            return UIFont(name: Fonts.ebFigtree, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
        case .figtreeRegular10:
            return UIFont(name: Fonts.rFigtree, size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .regular)
        case .figtreeRegular12:
            return UIFont(name: Fonts.rFigtree, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
    
    func swiftUIFont() -> Font {
        switch self {
        case .figtreeExBold12:
            return Font.custom(Fonts.ebFigtree, size: 12)
        case .figtreeExBold16:
            return Font.custom(Fonts.ebFigtree, size: 16)
        case .figtreeExBold18:
            return Font.custom(Fonts.ebFigtree, size: 18)
        case .figtreeExBold24:
            return Font.custom(Fonts.ebFigtree, size: 24)
        case .figtreeRegular10:
            return Font.custom(Fonts.rFigtree, size: 10)
        case .figtreeRegular12:
            return Font.custom(Fonts.rFigtree, size: 12)
        }
    }
}

//struct AppFonts {
//    static let figtreeExBold12 = UIFont(name: Fonts.ebFigtree, size: 12)
//    static let figtreeExBold16 = UIFont(name: Fonts.ebFigtree, size: 16)
//    static let figtreeExBold18 = UIFont(name: Fonts.ebFigtree, size: 18)
//    static let figtreeExBold24 = UIFont(name: Fonts.ebFigtree, size: 24)
//
//    static let figtreeRegular10  = UIFont(name: Fonts.rFigtree, size: 10)
//    static let figtreeRegular12  = UIFont(name: Fonts.rFigtree, size: 12)
//
//}
