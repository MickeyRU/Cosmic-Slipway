import UIKit

protocol ConfigurableDetailView: UIView {
    func configure(with data: DetailViewUIModelProtocol)
}

protocol DetailViewUIModelProtocol {
    // Определи здесь общие свойства или методы для всех моделей данных
}
