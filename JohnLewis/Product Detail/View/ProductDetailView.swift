import UIKit

protocol ProductDetailView: class {
    func showErrorMessage(_ message: String)
    func showProductDetail(_ productDetail: ProductDetail)
    func showImage(_ image: UIImage)
}
