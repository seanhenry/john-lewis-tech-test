import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
