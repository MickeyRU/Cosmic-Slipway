import UIKit

struct BasicColors {
    static let accent = UIColor(hex: "11DCE8")
    static let darkBG = UIColor(hex: "091522")
    static let active = UIColor(hex: "FFFFFF")
    static let iconText = UIColor(hex: "8D8E99")
    
    static func colorWithAlpha(_ color: UIColor, withAlpha alpha: CGFloat) -> UIColor {
        return color.withAlphaComponent(alpha)
    }
}

struct HighlightsColors {
    static let pureBlack = UIColor(hex: "000")
    static let gradient = [UIColor(hex: "00E5E5", alpha: 1),
                           UIColor(hex: "E961FF", alpha: 1)]
}
