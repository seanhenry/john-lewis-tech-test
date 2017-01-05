import UIKit

protocol ProductListView: class {
    func showErrorMessage(_ message: String)
    func showProducts(_ products: [Product])
    func showImage(image: UIImage, at index: Int)
}
