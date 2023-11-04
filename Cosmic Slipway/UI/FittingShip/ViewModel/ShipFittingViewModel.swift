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
    
    
    private func loadShip(with shipID: UUID) {
        DispatchQueue.global(qos: .background).async {
            let result = ShipDataService.shared.getShip(byID: shipID)
            DispatchQueue.main.async {
                self.ship.send(result)
            }
        }
    }
    
    private func handleOkButtonTapped() {
        print("okButtonPressed")
    }
    
    private func handleExitButtonTapped() {
        print("exitButtonPressed")
    }
}
