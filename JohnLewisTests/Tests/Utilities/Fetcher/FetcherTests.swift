import Foundation
import XCTest
@testable import JohnLewis

class FetcherTests: XCTestCase {

    var fetcher: Fetcher<String>!
    var mockedRequest: MockRequest!
    var mockedParser: MockParser<String>!
    let data = "some data".data(using: .utf8)!
    let path = "/path/to/resource"

    override func setUp() {
        super.setUp()
        mockedRequest = MockRequest()
        mockedParser = MockParser()
        fetcher = Fetcher(request: mockedRequest, parser: mockedParser)
    }

    // MARK: - fetch

    func test_fetch_shouldMakeNetworkRequest() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequest.invokedPath, path)
    }

    func test_fetch_shouldPassError_whenNetworkError() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    func test_fetch_shouldPassError_whenParserError() {
        mockedRequest.stubbedResult = .success(data)
        mockedParser.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    // MARK: - Helpers

    @discardableResult
    func fetchSynchronously() -> Result<String, Error> {
        var result: Result<String, Error>!
        fetcher.fetch(path: path) { r in
            result = r
        }
        return result
    }
}
