import Foundation
@testable import JohnLewis

class MockParser<ParsedType>: DataParser<ParsedType> {

    var invokedData: Data?
    var stubbedResult: ParsedResult = .failure(testError)
    override func parse(_ data: Data) -> ParsedResult {
        invokedData = data
        return stubbedResult
    }
}
