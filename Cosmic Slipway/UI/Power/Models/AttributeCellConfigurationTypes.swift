import UIKit

struct AttributeCellConfiguration {
    let type: AttributeCellConfigurationTypes
    let uiModel: DetailViewUIModelProtocol
}

enum AttributeCellConfigurationTypes: Int, CaseIterable {
    case offense = 0
    case defense = 1
    case capacitor = 2
    case targeting = 3
    case navigation = 4
    
    var height: CGFloat {
        switch self {
        case .offense:
            return 200
        case .defense:
            return 300
        case .capacitor, .targeting, .navigation:
            return 200
        }
    }
    
    var title: String {
        switch self {
        case .offense:
            return NSLocalizedString("offenseTitle", tableName: "PowerLocalization", comment: "")
        case .defense:
            return NSLocalizedString("defenseTitle", tableName: "PowerLocalization", comment: "")
        case .capacitor:
            return NSLocalizedString("capacitorTitle", tableName: "PowerLocalization", comment: "")
        case .targeting:
            return NSLocalizedString("targetingTitle", tableName: "PowerLocalization", comment: "")
        case .navigation:
            return NSLocalizedString("navigationTitle", tableName: "PowerLocalization", comment: "")
        }
    }
    
    var subtitle: String {
        switch self {
        case .offense:
            return NSLocalizedString("offenseSubTitle", tableName: "PowerLocalization", comment: "")
        case .defense:
            return NSLocalizedString("defenseSubTitle", tableName: "PowerLocalization", comment: "")
        case .capacitor:
            return NSLocalizedString("capacitorSubTitle", tableName: "PowerLocalization", comment: "")
        case .targeting:
            return NSLocalizedString("targetingSubTitle", tableName: "PowerLocalization", comment: "")
        case .navigation:
            return NSLocalizedString("navigationSubTitle", tableName: "PowerLocalization", comment: "")
        }
    }
    
    var image: UIImage? {
        switch self {
        case .offense:
            return UIImage.offenseIcon
        case .defense:
            return UIImage.defenseIcon
        case .capacitor:
            return UIImage.capacitorIcon
        case .targeting:
            return UIImage.targetingIcon
        case .navigation:
            return UIImage.navigationIcon
        }
    }
}
