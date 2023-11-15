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
}

protocol ViewsFactoryProtocol {
    func createBGImageView(for screen: BackgroundImageType) -> UIImageView
    func createBGView(alpha: Alpha) -> UIView
    func createShipImageView() -> UIImageView
    func createTitle(for title: TitleType) -> UILabel
    func createAddShipImage() -> UIImageView
    
    func createButton(type: ButtonTypes) -> UIButton
}

final class ViewsFactory: ViewsFactoryProtocol {
    func createBGImageView(for screen: BackgroundImageType) -> UIImageView {
        let imageView = baseImageView()
        
        switch screen {
        case .main:
            imageView.image = BgImages.mainBackImage
        case .shipSelection:
            imageView.image = BgImages.shipSelectionBgImage
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
            label.textAlignment = .left
            label.textColor = .white
            label.font = CustomFonts.figtreeExBold12
            label.adjustsFontSizeToFitWidth = true // Автоматическое уменьшение размера шрифта
            label.numberOfLines = 0 // Позволяет тексту размещаться на нескольких строках
            
        }
        return label
    }
    
    func createAddShipImage() -> UIImageView {
        let imageView = baseImageView(image: NavigationImages.addButton)
        return imageView
    }
    
    func createButton(type: ButtonTypes) -> UIButton {
        let button = UIButton(type: .custom)
        switch type {
        case .okButton:
            button.setImage(NavigationImages.okButton, for: .normal)
        case .exitButton:
            button.setImage(NavigationImages.exitButton, for: .normal)
        case .addButton:
            button.setImage(NavigationImages.addButton, for: .normal)
        }
        return button
    }
    
    private func baseImageView(image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}
