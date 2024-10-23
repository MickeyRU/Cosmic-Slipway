import SwiftUI

struct ScreenBGImageView: View {
    let image: ImageResource
    
    var body: some View {
        Image(image)
            .resizable()
            .ignoresSafeArea()
    }
}
