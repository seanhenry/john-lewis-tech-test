@testable import JohnLewis

class MockProductDetailRouter: ProductDetailRouter {

    var didShowProductDetails = false
    var invokedID: String?
    func showProductDetails(id: String) {
        didShowProductDetails = true
        invokedID = id
    }
}
