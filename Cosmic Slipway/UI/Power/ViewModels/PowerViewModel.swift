import Foundation
import Combine

final class PowerViewModel: PowerViewModelProtocol {
    private (set) var cellConfigurationsSubject = PassthroughSubject<[AttributeCellConfiguration], Never>()
    private var attributes: [AttributeCellConfiguration] = []
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        self.attributes = [AttributeCellConfiguration(type: .offense, uiModel: OffenseViewUIModel()),
                           AttributeCellConfiguration(type: .defense, uiModel: OffenseViewUIModel()),
                           AttributeCellConfiguration(type: .capacitor, uiModel: OffenseViewUIModel()),
                           AttributeCellConfiguration(type: .targeting, uiModel: OffenseViewUIModel()),
                           AttributeCellConfiguration(type: .navigation, uiModel: OffenseViewUIModel())]
        cellConfigurationsSubject.send(attributes)
    }
    
    func numberOfItemsInSection() -> Int {
        return AttributeCellConfigurationTypes.allCases.count
    }
    
    func configurationForCell(at indexPath: IndexPath) -> AttributeCellConfiguration? {
        guard indexPath.row < attributes.count else { return nil }
        let attribute = attributes[indexPath.row]
        return AttributeCellConfiguration(type: attribute.type, uiModel: attribute.uiModel)
    }
}
