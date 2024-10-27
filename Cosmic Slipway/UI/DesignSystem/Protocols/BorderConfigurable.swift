import UIKit

protocol BorderConfigurable {
    func addBorder(to view: UIView, cornerRadius: CGFloat, lineWidth: CGFloat, borderColors: [UIColor], startPoint: CGPoint, endPoint: CGPoint)
}

extension BorderConfigurable where Self: UIView {
    func addBorder(to view: UIView, cornerRadius: CGFloat, lineWidth: CGFloat, borderColors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayerName = "gradientLayer"
        
        // Поиск или создание градиентного слоя
        let gradientLayer: CAGradientLayer
        if let existingLayer = view.layer.sublayers?.first(where: { $0.name == gradientLayerName }) as? CAGradientLayer {
            gradientLayer = existingLayer
        } else {
            gradientLayer = CAGradientLayer()
            gradientLayer.name = gradientLayerName
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        // Обновление frame градиентного слоя и его свойств
        gradientLayer.frame = view.bounds
        gradientLayer.colors = borderColors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Обновление маски
        let maskLayer: CAShapeLayer
        if let mask = gradientLayer.mask as? CAShapeLayer {
            maskLayer = mask
        } else {
            maskLayer = CAShapeLayer()
            gradientLayer.mask = maskLayer
        }
        
        // Обновление path маски
        maskLayer.path = UIBezierPath(roundedRect: view.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius).cgPath
        maskLayer.lineWidth = lineWidth
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
    }
}
