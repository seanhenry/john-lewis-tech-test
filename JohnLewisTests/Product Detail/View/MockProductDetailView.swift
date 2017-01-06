@testable import JohnLewis

class MockProductDetailView: ProductDetailView {

    var invokedErrorMessage: String?
    func showErrorMessage(_ message: String) {
        invokedErrorMessage = message
    }

    var invokedProductDetail: ProductDetail?
    func showProductDetail(_ productDetail: ProductDetail) {
        invokedProductDetail = productDetail
    }
}
