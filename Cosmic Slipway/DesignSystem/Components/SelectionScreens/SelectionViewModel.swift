import Foundation
import Combine

final class SelectionViewModel<DataType: Nameable> {
    let data: [DataType]
    let selectedData = PassthroughSubject<DataType, Never>()

    init(data: [DataType]) {
        self.data = data
    }

    func didSelectItemAt(index: Int) {
        let dataAtIndex = data[index]
        selectedData.send(dataAtIndex)
    }
}
