import Combine
import UIKit

final class ShipFittingViewModel {
    
    let okButtonTapped = PassthroughSubject<Void, Never>()
    let exitButtonTapped = PassthroughSubject<Void, Never>()
    
    let userSelectSlotForFitting = PassthroughSubject<ChosenSlotType, Never>()
    let moduleTypesData = PassthroughSubject<Void, Never>()
    
    var ship: CurrentValueSubject<Ship?, Never>
    
    // Subject для ошибок
    var error: PassthroughSubject<String, Never> = PassthroughSubject()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(shipID: UUID) {
        ship = CurrentValueSubject(nil)
        loadShip(with: shipID)
        
        // Подписка на события кнопок
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
        
        userSelectSlotForFitting
               .sink(receiveValue: { [weak self] moduleSelection in
                   guard let self = self else { return }
                   self.handleModuleSelected(moduleSelection)
               })
               .store(in: &cancellables)
    }
    
    func getShipViewModel() -> ShipUIViewModel? {
        guard let currentShip = ship.value else {
            return nil
        }
        
        guard let image = UIImage(named: currentShip.shipImage) else {
            error.send("Ошибка: изображение корабля не найдено.")
            return nil
        }
        
        return ShipUIViewModel(image: image,
                               title: currentShip.name,
                               subTitle: "Your Ship",
                               isAddButtonVisible: false)
    }
    
    private func handleOkButtonTapped() {
        // Проверяем, есть ли текущий корабль для сохранения.
        guard let currentShip = ship.value else {
            error.send("Ошибка: корабль не найден или данные неполные.")
            return
        }
        
        // Создаём новый экземпляр корабля с новым ID конфигурации.
        let newShipConfiguration = createNewShipConfiguration(for: currentShip.id, with: currentShip.fitting)
        
        // Сохраняем новый экземпляр корабля.
        ShipManagementService.shared.saveUserShip(newShipConfiguration)
    }
    
    
    private func handleExitButtonTapped() {
        print("exitButtonPressed")
    }
    
    private func handleModuleSelected(_ selection: ChosenSlotType) {
        ModuleManagementService.shared.sortModuleTypeData(selection: selection)
        self.moduleTypesData.send()
    }
    
    private func createNewShipConfiguration(for shipId: UUID, with fitting: Fitting) -> Ship {
        // Получаем информацию о базовом корабле по его ID.
        let baseShip = ShipManagementService.shared.getShip(byID: shipId)
        
        // Создаём новую конфигурацию с уникальным ID конфигурации, но тем же ID корабля.
        return Ship(cloning: baseShip, withNewFitting: fitting)
    }
    
    private func loadShip(with shipID: UUID) {
        DispatchQueue.global(qos: .background).async {
            let result = ShipManagementService.shared.getShip(byID: shipID)
            DispatchQueue.main.async {
                self.ship.send(result)
            }
        }
    }
}
