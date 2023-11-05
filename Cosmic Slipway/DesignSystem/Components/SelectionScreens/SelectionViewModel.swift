import Foundation
import Combine

final class SelectionViewModel<DataType: Nameable> {
    let data: [DataType]
    let selectedShipData = PassthroughSubject<DataType, Never>()

    init(data: [DataType]) {
        self.data = data
    }

    func didSelectItemAt(index: Int) {
        let dataAtIndex = data[index]
        selectedShipData.send(dataAtIndex)
    }
}
