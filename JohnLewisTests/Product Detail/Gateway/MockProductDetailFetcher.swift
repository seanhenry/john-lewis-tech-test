@testable import JohnLewis

class MockProductDetailFetcher: ProductDetailFetcher {

    var didFetch = false
    var invokedID: String?
    var stubbedResult: ProductDetailResult = .failure(testError)
    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ()) {
        didFetch = true
        invokedID = id
        completion(stubbedResult)
    }
}

