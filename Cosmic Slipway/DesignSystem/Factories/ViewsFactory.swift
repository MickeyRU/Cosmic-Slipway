import UIKit

enum Alpha: CGFloat {
    case heavyTransparent = 0.5
    case mediumTransparent = 0.65
    case lowTransparent = 0.95
}

enum BackgroundImageType {
    case main
    case shipSelection
}

enum TitleType {
    case shipTitle
    case shipDescription
    case shipTypeInCell
    case shipSelectionPageTitle
    case moduleTitle
}

enum ButtonTypes {
    case okButton
    case exitButton
    case addButton
    case detailsButton
}

protocol ViewsFactoryProtocol {
    func createBGImageView(for screen: BackgroundImageType) -> UIImageView
    func createBGView(alpha: Alpha) -> UIView
    func createShipImageView() -> UIImageView
    func createTitle(for title: TitleType) -> UILabel
    func createAddShipImage() -> UIImageView
    
    func updateButton(_ button: UIButton, withType type: ButtonTypes)
}

final class ViewsFactory: ViewsFactoryProtocol {
    func createBGImageView(for screen: BackgroundImageType) -> UIImageView {
        let imageView = baseImageView()
        
        switch screen {
        case .main:
            imageView.image = UIImage.mainBG
        case .shipSelection:
            imageView.image = UIImage.shipSelectionBG
        }
        
        return imageView
    }
    
    func createBGView(alpha: Alpha) -> UIView {
        let view = UIView()
        view.backgroundColor = BasicColors.colorWithAlpha(BasicColors.darkBG, withAlpha: alpha.rawValue)
        return view
    }
    
    func createShipImageView() -> UIImageView  {
        return baseImageView(image: nil)
    }
    
    func createTitle(for title: TitleType) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        
        switch title {
        case .shipTitle:
            label.textColor = BasicColors.accent
            label.font = CustomFonts.figtreeExBold16
        case .shipDescription:
            label.textColor = BasicColors.iconText
            label.font = CustomFonts.figtreeRegular10
        case .shipTypeInCell:
            label.textColor = .white
            label.textAlignment = .center
            label.font = CustomFonts.figtreeExBold16
        case .shipSelectionPageTitle:
            label.textColor = BasicColors.accent
            label.textAlignment = .center
            label.font = CustomFonts.figtreeExBold24
        case .moduleTitle:
            label.textColor = .white
            label.font = CustomFonts.figtreeExBold12
        }
        return label
    }
    
    func createAddShipImage() -> UIImageView {
        let imageView = baseImageView(image: UIImage.addButton)
        return imageView
    }
        
    func updateButton(_ button: UIButton, withType type: ButtonTypes) {
        switch type {
        case .okButton:
            button.setImage(UIImage.okButton, for: .normal)
        case .exitButton:
            button.setImage(UIImage.exitButton, for: .normal)
        case .addButton:
            button.setImage(UIImage.addButton, for: .normal)
        case .detailsButton:
            button.setImage(UIImage.detailsButton, for: .normal)
        }
    }

    
    private func baseImageView(image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}
