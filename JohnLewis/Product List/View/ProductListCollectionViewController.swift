import UIKit

class ProductListCollectionViewController: UICollectionViewController, ProductListView {

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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.setProduct(products[indexPath.item])
        return cell
    }
}
