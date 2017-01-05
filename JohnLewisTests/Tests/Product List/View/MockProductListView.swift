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
}
