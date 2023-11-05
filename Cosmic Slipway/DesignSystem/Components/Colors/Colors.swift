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
