import SnapKit
import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewsFactory: ViewsFactoryProtocol
    private let bgImageView: UIImageView
    private lazy var shipCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ShipsCell.self, forCellWithReuseIdentifier: ShipsCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private enum collectionViewInsets {
        static let sideInsets: CGFloat = 24
        static let cellHeight: CGFloat = 96
    }
    
    // MARK: - init
    
    init(viewsFactory: ViewsFactoryProtocol = ViewsFactory()) {
        self.viewsFactory = viewsFactory
        self.bgImageView = viewsFactory.createBGImageView(for: .main)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController LC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    // MARK: - Private Methods
    
    private func layout() {
        [bgImageView, shipCollectionView].forEach { view.addSubview($0) }
        
        bgImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view)
        }
        
        shipCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShipsCell.reuseIdentifier, for: indexPath) as? ShipsCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 28
        cell.clipsToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInserts = UIEdgeInsets(top: 0, left: collectionViewInsets.sideInsets, bottom: 0, right: collectionViewInsets.sideInsets)
        let width = view.frame.width - (cellInserts.left + cellInserts.right)
        return CGSize(width: width, height: collectionViewInsets.cellHeight)
    }
}
