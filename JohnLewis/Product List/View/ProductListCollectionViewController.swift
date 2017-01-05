import UIKit

class ProductListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ProductListView {

    var eventHandler: ProductListEventHandler!
    private var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.fetchProducts()
    }

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.eventHandler.fetchProducts()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func showProducts(_ products: [Product]) {
        self.products = products
        collectionView?.reloadData()
    }

    func showImage(image: UIImage, at index: Int) {
        cellForItem(at: index)?.setImage(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnCount: CGFloat = UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) ? 3 : 4
        let aspectRatio: CGFloat = 0.72
        let width = collectionView.frame.width / columnCount
        return CGSize(width: width, height: width / aspectRatio)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.setProduct(products[indexPath.item])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        eventHandler.fetchImage(at: indexPath.item)
    }

    private func cellForItem(at index: Int) -> ProductCell? {
        return collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ProductCell
    }
}
