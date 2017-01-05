import Foundation
@testable import JohnLewis

class MockRequestFactory: RequestFactory {

    let stubbedRequest = MockRequest()
    var invokedURL: URL?
    func create(fromURL url: URL) -> Request {
        invokedURL = url
        return stubbedRequest
    }
}
