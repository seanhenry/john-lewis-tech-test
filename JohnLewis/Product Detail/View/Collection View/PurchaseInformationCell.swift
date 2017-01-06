import UIKit

class PurchaseInformationCell: UICollectionViewCell {

    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var guaranteeLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        priceLabel.text = nil
    }

    func setPrice(_ price: String) {
        priceLabel.text = price
    }

    func setGuarantee(_ guarantee: String) {
        guaranteeLabel.text = guarantee
    }
}
