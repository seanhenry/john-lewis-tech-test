import UIKit
@testable import JohnLewis

class MockProductListView: ProductListView {

    var invokedErrorMessage: String?
    func showErrorMessage(_ message: String) {
        invokedErrorMessage = message
    }

    var invokedProducts: [Product]?
    func showProducts(_ products: [Product]) {
        invokedProducts = products
    }

    var invokedImage: UIImage?
    var invokedImageIndex: Int?
    func showImage(image: UIImage, at index: Int) {
        invokedImage = image
        invokedImageIndex = index
    }
}
