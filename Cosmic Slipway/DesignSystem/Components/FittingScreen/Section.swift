import UIKit

enum Section: Int, CaseIterable {
    case selectedShip = 0
    case highSlot
    case midSlot
    case lowSlot
    case combatRig
    case engineeringRig
    
    func titleAndImage() -> (title: String, image: UIImage) {
        switch self {
        case .highSlot:
            return ("High Slot", ModuleImages.highSlotClean)
        case .midSlot:
            return ("Mid Slot", ModuleImages.midSlotClean)
        case .lowSlot:
            return ("Low Slot", ModuleImages.lowSlotClean)
        case .combatRig:
            return ("Combat Rig", ModuleImages.combatRigClean)
        case .engineeringRig:
            return ("Engineering Rig", ModuleImages.engineerRigsClean)
        default:
            return ("", UIImage())
        }
    }
}
