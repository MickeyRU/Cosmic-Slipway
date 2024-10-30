import SwiftUI

struct EditButtonWithArrowView: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text(text)
                .font(AppFonts.figtreeExBold12SwiftUI)
                .foregroundStyle(.active)
            
            Image(.detailsButton)
                .renderingMode(.template)
                .foregroundStyle(.accent)
        }
    }
}
