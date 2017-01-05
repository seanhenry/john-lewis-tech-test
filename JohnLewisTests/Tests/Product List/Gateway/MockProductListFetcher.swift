@testable import JohnLewis

class MockProductListFetcher: ProductListFetcher {

    var didFetch = false
    var stubbedResult = ProductListFetcherResult.failure(testError)
    func fetch(completion: @escaping (ProductListFetcherResult) -> ()) {
        didFetch = true
        completion(stubbedResult)
    }
}
