import SwiftUI

enum ImageSize: CGFloat {
    case regular = 50
}

struct SkillImageView: View {
    let image: String
    let size: ImageSize

    var body: some View {
        Image(image)
        .renderingMode(.template)
        .foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: [.gradientFrom, .gradientMiddle, .gradientTo]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
                )
        )
        .frame(width: size.rawValue, height: size.rawValue)
    }
}
