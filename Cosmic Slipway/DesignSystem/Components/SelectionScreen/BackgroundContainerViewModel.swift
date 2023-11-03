import Foundation
import Combine

final class BackgroundContainerViewModel<DataType: Nameable> {
    let shipsData: [DataType]
    let selectedShipData = PassthroughSubject<DataType, Never>()

    init(shipsData: [DataType]) {
        self.shipsData = shipsData
    }

    func didSelectItemAt(index: Int) {
        let shipData = shipsData[index]
        selectedShipData.send(shipData)
    }
}
