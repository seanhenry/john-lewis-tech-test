import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    func setProduct(_ product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price
    }
}
