import Foundation
import Combine

protocol PowerViewModelProtocol {
    var cellConfigurationsSubject: PassthroughSubject<[AttributeCellConfiguration], Never> { get }
    
    func loadData()
    func numberOfItemsInSection() -> Int
    func configurationForCell(at indexPath: IndexPath) -> AttributeCellConfiguration?
}
