import Foundation
@testable import JohnLewis

class MockRequest: Request {

    var didGet = false
    var invokedPath: String?
    var invocationCount = 0
    var stubbedResult = Result<Data, Error>.failure(testError)

    func get(from path: String, completion: @escaping Request.Completion) {
        didGet = true
        invocationCount += 1
        invokedPath = path
        completion(stubbedResult)
    }
}

