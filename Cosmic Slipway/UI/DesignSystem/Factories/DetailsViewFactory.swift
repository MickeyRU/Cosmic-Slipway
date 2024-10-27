import UIKit

protocol DetailsViewFactoryProtocol {
    func createLabel(withText text: String, font: UIFont?, textColor: UIColor?, aligment: NSTextAlignment) -> UILabel
    func createImageView(withImageName uiImageName: UIImage) -> UIImageView
}

final class DetailsViewFactory: DetailsViewFactoryProtocol {
    func createLabel(withText text: String, font: UIFont?, textColor: UIColor?, aligment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = aligment
        return label
    }
    
    func createImageView(withImageName uiImageName: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = uiImageName
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
