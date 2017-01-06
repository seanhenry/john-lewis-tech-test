import UIKit

class ProductDetailCollectionViewController: UICollectionViewController, ProductDetailView {

    var productDetail: ProductDetail?
    var eventHandler: ProductDetailEventHandler!

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func showProductDetail(_ productDetail: ProductDetail) {
        self.productDetail = productDetail
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.fetchDetails()
    }

    override func numberOfSections(`in` collectionView: UICollectionView) -> Int {
        return productDetail != nil ? 3 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail != nil ? 1 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
