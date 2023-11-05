import Combine
import UIKit

final class ShipFittingViewModel {
    // Subjects для команд
    let okButtonTapped = PassthroughSubject<Void, Never>()
    let exitButtonTapped = PassthroughSubject<Void, Never>()
    
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
                               addShipImage: nil)
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
        ShipDataService.shared.saveUserShip(newShipConfiguration)
    }
    
    
    private func handleExitButtonTapped() {
        print("exitButtonPressed")
    }
    
    private func createNewShipConfiguration(for shipId: UUID, with fitting: Fitting) -> Ship {
        // Получаем информацию о базовом корабле по его ID.
        let baseShip = ShipDataService.shared.getShip(byID: shipId)
        
        // Создаём новую конфигурацию с уникальным ID конфигурации, но тем же ID корабля.
        return Ship(cloning: baseShip, withNewFitting: fitting)
    }
    
    private func loadShip(with shipID: UUID) {
        DispatchQueue.global(qos: .background).async {
            let result = ShipDataService.shared.getShip(byID: shipID)
            DispatchQueue.main.async {
                self.ship.send(result)
            }
        }
    }
}

/// Работа с модулями
extension ShipFittingViewModel {
    // Метод для добавления модуля в конкретный слот
    func addModule(_ module: Module, to slotType: ModuleType) {
        guard var currentFitting = ship.value?.fitting else { return }
        
        // Определяем, в какой слот будет добавлен модуль
        switch slotType {
        case .high:
            if currentFitting.highSlots.count < currentFitting.maxHighSlots {
                currentFitting.highSlots.append(module)
            }
        case .mid:
            if currentFitting.midSlots.count < currentFitting.maxMidSlots {
                currentFitting.midSlots.append(module)
            }
        case .low:
            if currentFitting.lowSlots.count < currentFitting.maxLowSlots {
                currentFitting.lowSlots.append(module)
            }
        case .combatRig:
            if currentFitting.combatRigs.count < currentFitting.maxCombatRigs {
                currentFitting.combatRigs.append(module)
            }
        case .engineeringRig:
            if currentFitting.engineeringRigs.count < currentFitting.maxEngineeringRigs {
                currentFitting.engineeringRigs.append(module)
            }
        }
        
        // Обновляем текущий корабль с новым fitting, если добавление модуля произошло успешно
        ship.value?.fitting = currentFitting
        ship.send(ship.value)
    }

    // Метод для удаления модуля из конкретного слота
    func removeModule(_ module: Module, from slotType: ModuleType) {
        guard var currentFitting = ship.value?.fitting else { return }
        
        // Определяем, из какого слота будет удален модуль
        switch slotType {
        case .high:
            currentFitting.highSlots.removeAll { $0.id == module.id }
        case .mid:
            currentFitting.midSlots.removeAll { $0.id == module.id }
        case .low:
            currentFitting.lowSlots.removeAll { $0.id == module.id }
        case .combatRig:
            currentFitting.combatRigs.removeAll { $0.id == module.id }
        case .engineeringRig:
            currentFitting.engineeringRigs.removeAll { $0.id == module.id }
        }
        
        // Обновляем текущий корабль с новым fitting, если удаление модуля произошло успешно
        ship.value?.fitting = currentFitting
        ship.send(ship.value)
    }
}
