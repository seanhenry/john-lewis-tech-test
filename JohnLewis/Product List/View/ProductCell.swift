import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1
    }

    func setProduct(_ product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
