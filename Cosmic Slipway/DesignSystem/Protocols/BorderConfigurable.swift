import UIKit

protocol BorderConfigurable {
    func addBorder(to view: UIView, cornerRadius: CGFloat, lineWidth: CGFloat, borderColors: [UIColor], startPoint: CGPoint, endPoint: CGPoint)
}

extension BorderConfigurable where Self: UIView {
    func addBorder(to view: UIView, cornerRadius: CGFloat, lineWidth: CGFloat, borderColors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayerName = "gradientLayer"
        
        if view.layer.sublayers?.first(where: { $0.name == gradientLayerName}) == nil {
            let gradientLayer = CAGradientLayer()
            gradientLayer.name = gradientLayerName
            gradientLayer.frame = view.bounds
            gradientLayer.colors = borderColors.map { $0.cgColor }
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            
            // Cлой для маски
            let maskLayer = CAShapeLayer()
            maskLayer.lineWidth = lineWidth
            maskLayer.path = UIBezierPath(roundedRect: view.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius).cgPath
            maskLayer.fillColor = UIColor.clear.cgColor
            maskLayer.strokeColor = UIColor.black.cgColor
            
            gradientLayer.mask = maskLayer
            view.layer.addSublayer(gradientLayer)
        }
    }
}
