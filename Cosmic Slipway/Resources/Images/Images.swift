import UIKit

// Фабрика изображений для безопасной загрузки и обработки отсутствующих ресурсов.
enum ImageFactory {
    static func safeImage(named name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            // Логирование ошибки или другие меры при отсутствии изображения
            print("Внимание: Отсутствует изображение с именем \(name)")
            return UIImage() // Возвращаем пустое изображение в качестве запасного
        }
        return image
    }
}

// Фоновые изображения
enum BgImages {
    static let mainBackImage: UIImage = ImageFactory.safeImage(named: "mainBackImage")
    static let shipSelectionBgImage: UIImage = ImageFactory.safeImage(named: "shipSelectionBg")
    static let backBorderImage: UIImage = ImageFactory.safeImage(named: "backBorderImage")
}

// Изображения кораблей
enum ShipImages {
    static let defaultShipImage: UIImage = ImageFactory.safeImage(named: "shipImage")
    static let megathronStriker: UIImage = ImageFactory.safeImage(named: "megathronStriker")
}

// Изображения модулей
enum ModuleImages {
    static let highSlotClean: UIImage = ImageFactory.safeImage(named: "highSlotClean")
    static let midSlotClean: UIImage = ImageFactory.safeImage(named: "midSlotClean")
    static let lowSlotClean: UIImage = ImageFactory.safeImage(named: "lowSlotClean")
    static let combatRigClean: UIImage = ImageFactory.safeImage(named: "combatRigClean")
    static let engineerRigsClean: UIImage = ImageFactory.safeImage(named: "enginRigsClean")
}

// Изображения для навигации
enum NavigationImages {
    static let homeTabBarClean: UIImage = ImageFactory.safeImage(named: "homeTabBarClean")
    static let homeTabBarSelected: UIImage = ImageFactory.safeImage(named: "homeTabBarSelected")
    static let fittingTabBarClean: UIImage = ImageFactory.safeImage(named: "fittingTabBarClean")
    static let fittingTabBarSelected: UIImage = ImageFactory.safeImage(named: "fittingTabBarSelected")
    static let addButtonImage: UIImage = ImageFactory.safeImage(named: "addButtonImage")
    static let backButton: UIImage = ImageFactory.safeImage(named: "backButton")
    static let exitButton: UIImage = ImageFactory.safeImage(named: "exitButton")
    static let okButton: UIImage = ImageFactory.safeImage(named: "okButton")
}
