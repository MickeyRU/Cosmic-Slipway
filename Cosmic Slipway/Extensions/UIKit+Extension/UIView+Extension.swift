import UIKit

extension UIView {
    func addSubviewWithOutTAMIC(_ view: UIView){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
