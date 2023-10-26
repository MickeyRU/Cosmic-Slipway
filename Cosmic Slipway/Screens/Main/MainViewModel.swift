import Foundation
import Combine

protocol MainViewModelProtocol {
    var ships: [Ship] { get}
    var shipsPublisher: AnyPublisher<[Ship], Never> { get }  // добавить эту строку
}

final class MainViewModel: ObservableObject, MainViewModelProtocol {
    
    @Published
    private (set) var ships: [Ship] = []
    
    var shipsPublisher: AnyPublisher<[Ship], Never> {
        $ships.eraseToAnyPublisher()  
    }
}
