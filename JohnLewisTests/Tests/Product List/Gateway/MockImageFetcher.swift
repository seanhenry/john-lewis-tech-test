import Foundation
@testable import JohnLewis

class MockImageFetcher: ImageFetcher {

    var didFetch = false
    var invokedURL: URL?
    var stubbedResult = ImageFetcherResult.failure(testError)
    func fetch(from url: URL, completion: @escaping (ImageFetcherResult) -> ()) {
        didFetch = true
        invokedURL = url
        completion(stubbedResult)
    }
}
