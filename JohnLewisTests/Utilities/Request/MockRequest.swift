import Foundation
@testable import JohnLewis

class MockRequest: Request {

    var didGet = false
    var invokedPath: String?
    var stubbedResult = Result<Data, Error>.failure(testError)

    func get(from path: String, completion: @escaping Request.Completion) {
        didGet = true
        invokedPath = path
        completion(stubbedResult)
    }
}

