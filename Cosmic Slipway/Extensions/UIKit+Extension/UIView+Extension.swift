import UIKit

extension UIView {
    // Добаляет обводку с заданными парамметрами
    func addBorder(cornerRadius: CGFloat, lineWidth: CGFloat, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        
        self.layer.cornerRadius = cornerRadius
        
        // Создать градиентный слой
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Создать shape слой для обводки
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor //
        
        gradientLayer.mask = shapeLayer
        self.layer.addSublayer(gradientLayer)
    }
}
