import UIKit

class ProductDetailCollectionViewController: UICollectionViewController, ProductDetailView {

    var productDetail: ProductDetail?
    var eventHandler: ProductDetailEventHandler!
    @IBOutlet private var layout: ProductDetailLayout!

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func showProductDetail(_ productDetail: ProductDetail) {
        self.productDetail = productDetail
        collectionView?.reloadData()
        title = productDetail.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.fetchDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLayoutOrientation()
    }

    override func numberOfSections(`in` collectionView: UICollectionView) -> Int {
        return productDetail != nil ? 3 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail != nil ? 1 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productDetail = self.productDetail!
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurchaseInformationCell", for: indexPath) as! PurchaseInformationCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
            cell.setText(productDetail.description)
            return cell
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateLayoutOrientation()
        }, completion: nil)
    }

    private func updateLayoutOrientation() {
        layout.orientation = UIApplication.shared.statusBarOrientation
        collectionView?.layoutIfNeeded()
    }
}
