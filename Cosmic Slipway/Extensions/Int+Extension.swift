import Foundation

extension Int {
    func formattedWithSpaceSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
