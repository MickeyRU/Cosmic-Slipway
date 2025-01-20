import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject private var authorizationViewModel: AuthorizationViewModel
    @State private var isEditingUsername: Bool = false
    @State private var isEditingPassword: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            Image("cosmicSlipwayLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(x: 0, y: -300)
            
            VStack(alignment: .leading) {
                title
                usernameField
                passwordField
                forgotPasswordButton
                button
                VStack(alignment: .center) {
                    Text("or sign in using")
                        .font(AppFonts.figtreeRegular10SwiftUI)
                        .foregroundStyle(Color.gray)
                    HStack {
                        Image("twitter")
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        Image("facebook")
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                
                        Image("google")
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal, 50)
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
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var title: some View {
        Text("Sign in")
            .font(AppFonts.figtreeExBold36SwiftUI)
            .foregroundStyle(.active)
    }
    
    var usernameField: some View {
        TextField("Username", text: $username, onEditingChanged: { editing in
            isEditingUsername = editing
        })
        .padding(10)
        .background(.darkBG)
        .foregroundColor(isEditingUsername ? Color.active : Color.gray)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(isEditingUsername ? Color.active : Color.gray, lineWidth: 1)
        )
        .padding(.bottom, 20)
    }
    
    var passwordField: some View {
        TextField("Password", text: $password, onEditingChanged: { editing in
            isEditingPassword = editing
        })
        .padding(10)
        .background(.darkBG)
        .foregroundColor(isEditingPassword ? Color.active : Color.color)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(isEditingPassword ? Color.active : Color.color, lineWidth: 1)
        )
    }
    
    var button: some View {
        Button(action: {
            authorizationViewModel.authorizate()
            print("Логин: \(username), Пароль: \(password)")
        }) {
            Text("Sign in")
                .frame(maxWidth: .infinity)
                .padding(13)
                .font(AppFonts.figtreeExBold24SwiftUI)
                .foregroundStyle(.active)
                .background(LinearGradient(gradient: Gradient(colors: [
                    Color(UIColor.gradientFrom.withAlphaComponent(1.0)),
                    Color(UIColor.gradientMiddle.withAlphaComponent(1.0)),
                    Color(UIColor.gradientTo.withAlphaComponent(1.0))
                ]),
                                           startPoint: .bottomTrailing,
                                           endPoint: .topLeading))
                .cornerRadius(40)
        }
    }
    
    var forgotPasswordButton: some View {
        Text("Forgot Password?")
            .font(AppFonts.figtreeExBold18SwiftUI)
            .foregroundStyle(.accent)
            .padding(10)
            .onTapGesture {
                authorizationViewModel.forgotPassword()
            }
    }
    
}
