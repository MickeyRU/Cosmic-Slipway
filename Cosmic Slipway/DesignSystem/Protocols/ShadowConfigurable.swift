import UIKit

protocol ShadowConfigurable {
    func addShadow(to view: UIView, cornerRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat)
}

extension ShadowConfigurable where Self: UIView {
    func addShadow(to view: UIView, cornerRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        let markerLayerName = "markerLayer"
        if view.layer.sublayers?.first(where: { $0.name == markerLayerName }) == nil {
            // Создание маркерного слоя
            let markerLayer = CALayer()
            markerLayer.name = markerLayerName
            markerLayer.isHidden = true
            view.layer.addSublayer(markerLayer)
            
            // Настройка тени
            view.layer.cornerRadius = cornerRadius
            view.layer.shadowColor = shadowColor.cgColor
            view.layer.shadowOpacity = shadowOpacity
            view.layer.shadowOffset = shadowOffset
            view.layer.shadowRadius = shadowRadius
        }
    }
}
