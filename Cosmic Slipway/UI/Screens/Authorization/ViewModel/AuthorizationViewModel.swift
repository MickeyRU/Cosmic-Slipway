import Foundation

protocol AuthorizationViewModelProtocol {
    func authorizate()
    func forgotPassword() 
}

final class AuthorizationViewModel: ObservableObject {
    func authorizate() {}
    func forgotPassword() {}
}
