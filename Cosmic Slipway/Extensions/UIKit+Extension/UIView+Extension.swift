import UIKit

extension UIView {
    // Добаляет обводку с заданными парамметрами
    func addShadowAndBorder(cornerRadius: CGFloat, lineWidth: CGFloat, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint, shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        
        self.layer.cornerRadius = cornerRadius
        
        // Настройка тени
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        // Градиентный слой
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Shape слой для обводки
        let borderLayer = CAShapeLayer()
        borderLayer.lineWidth = lineWidth
        borderLayer.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius).cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.mask = borderLayer
        
        self.layer.addSublayer(gradientLayer)
    }
}
