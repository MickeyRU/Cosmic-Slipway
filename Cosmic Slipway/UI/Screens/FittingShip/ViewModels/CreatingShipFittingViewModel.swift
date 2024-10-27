import UIKit
import Combine

final class CreatingShipFittingViewModel: ShipFittingViewModelProtocol {
   
    // MARK: - UserActions Publishers
    let okButtonTapped = PassthroughSubject<Void, Never>()
    let exitButtonTapped = PassthroughSubject<Void, Never>()
    let slotForFitting = PassthroughSubject<SlotAndIndex, Never>()
    let moduleType = PassthroughSubject<Void, Never>()

    private(set) var ship: CurrentValueSubject<Ship?, Never>
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialaizer

    init(shipID: UUID) {
        self.ship = CurrentValueSubject(nil)
        self.loadShip(with: shipID)
        self.subscribe()
    }

    // MARK: - Private properties

    private func loadShip(with shipID: UUID) {
        DispatchQueue.global(qos: .background).async {
            guard let ship = ShipManagementService.shared.loadShip(by: shipID) else { return }
            self.ship.send(ship)
        }
    }

    private func subscribe() {
        okButtonTapped
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handleOkButtonTapped()
            })
            .store(in: &cancellables)

        exitButtonTapped
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handleExitButtonTapped()
            })
            .store(in: &cancellables)

        slotForFitting
            .sink(receiveValue: { [weak self] moduleSelection in
                guard let self = self else { return }
                self.handleModuleSelected(moduleSelection)
            })
            .store(in: &cancellables)

        ModuleManagementService.shared.$moduleForUpdate
            .sink { [weak self] moduleForUpdate in
                guard
                    let self = self,
                    let module = moduleForUpdate
                else {
                    return
                }
                self.updateShipFitting(with: module)
            }
            .store(in: &cancellables)
    }

    private func handleOkButtonTapped() {
        guard let ship = self.ship.value else { return }
        ShipManagementService.shared.saveNewShip(ship: ship)
    }


    private func handleExitButtonTapped() {
        print("exitButtonPressed")
    }

    private func handleModuleSelected(_ selection: SlotAndIndex) {
        ModuleManagementService.shared.sortModuleTypeData(selection: selection)
        self.moduleType.send()
    }

    private func updateShipFitting(with module: ModuleForUpdate) {
        guard let currentShip = ship.value else {
            return
        }

        let moduleForAdd = ModuleManagementService.shared.getModule(byID: module.moduleID)
        let index = module.chosenSlotType.indexPath.row
        let slotType = module.chosenSlotType.slot

        let newFitting = currentShip.fitting.updatedFitting(withUpdatedSlot: slotType,
                                                            atIndex: index,
                                                            newModule: moduleForAdd)

        let updatedShip = currentShip.withUpdatedFitting(newFitting)
        self.ship.send(updatedShip)
    }
}
