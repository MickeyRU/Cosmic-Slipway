import UIKit

enum ScreenTypes {
    case main
}

enum TitleType {
    case shipTitle
    case shipDescription
}

protocol ViewsFactoryProtocol {
    func createBGImageView(for screen: ScreenTypes) -> UIImageView
    func createBGView() -> UIView
    func createShipImageView() -> UIImageView
    func createTitle(for title: TitleType) -> UILabel
    func createAddShipImage() -> UIImageView
}

final class ViewsFactory: ViewsFactoryProtocol {
    func createBGImageView(for screen: ScreenTypes) -> UIImageView {
        let imageView = baseImageView()
        
        switch screen {
        case .main:
            imageView.image = BgImages.mainBackImage
        }
        
        return imageView
    }
    
    
    func createBGView() -> UIView {
        let view = UIView()
        view.backgroundColor = BasicColors.colorWithAlpha(BasicColors.darkBG, withAlpha: 0.7)
        return view
    }
    
    func createShipImageView() -> UIImageView  {
        return baseImageView(image: ShipImages.defaultShipImage)
    }
    
    func createTitle(for title: TitleType) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        
        switch title {
        case .shipTitle:
            label.text = "New ship +"
            label.textColor = BasicColors.accent
            label.font = CustomFonts.figtreeBold16
        case .shipDescription:
            label.text = "Configure"
            label.textColor = BasicColors.iconText
            label.font = CustomFonts.figtreeRegular12
        }
        return label
    }
    
    func createAddShipImage() -> UIImageView {
        let imageView = baseImageView(image: NavigationImages.addButtonImage)
        return imageView
    }
    
    private func baseImageView(image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
}
