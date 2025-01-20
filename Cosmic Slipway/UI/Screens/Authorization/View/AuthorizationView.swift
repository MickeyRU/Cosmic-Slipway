import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject private var authorizationViewModel: AuthorizationViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            VStack(spacing: 40) {
                Image("cosmicSlipwayLogo")
                VStack {
                    Text("Sign in")
                        .font(AppFonts.figtreeExBold24SwiftUI)
                        .foregroundStyle(.active)
                    TextField("Login", text: $username)
                        .padding()
                        .background(.darkBG)
                        .foregroundColor(.active)
                        .cornerRadius(40)
                        .padding(.bottom, 20)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.darkBG)
                        .foregroundColor(.active)
                        .cornerRadius(40)
                        .padding(.bottom, 20)
                    Button(action: {
                        authorizationViewModel.authorizate()
                        print("Логин: \(username), Пароль: \(password)")
                    }) {
                        Text("Sign in")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(40)
//                            .background(LinearGradient(stops: <#T##[Gradient.Stop]#>, startPoint: .init(x: 0.9, y: 0), endPoint: .init(x: 0.1, y: 1)))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .background(Color.darkBG.opacity(Alpha.mediumTransparent.rawValue))
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [
                                Color(UIColor.gradientFrom.withAlphaComponent(0.2)),
                                Color(UIColor.gradientMiddle.withAlphaComponent(0.4)),
                                Color(UIColor.gradientTo.withAlphaComponent(0.2))
                            ]),
                            startPoint: .init(x: 0, y: 0),
                            endPoint: .init(x: 0, y: 0)
                        ), lineWidth: 1)
                )
            }
        }
        
    }
}
