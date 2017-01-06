import XCTest
@testable import JohnLewis

class NetworkProductDetailFetcherTests: XCTestCase {

    var fetcher: NetworkProductDetailFetcher!
    var mockedRequest: MockRequest!

    override func setUp() {
        super.setUp()
        mockedRequest = MockRequest()
        fetcher = NetworkProductDetailFetcher(request: mockedRequest)
    }

    // MARK: - fetch

    func test_fetch_shouldRequestProductDetails() {
        fetchSynchronously(id: "123")
        XCTAssertEqual(mockedRequest.invokedPath, "/products/123")
    }

    func test_fetch_shouldCompleteWithError_whenNetworkFails() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    // MARK: - Helpers

    @discardableResult
    func fetchSynchronously(id: String = "id") -> ProductDetailResult {
        var result: ProductDetailResult!
        fetcher.fetch(id: id) { r in
            result = r
        }
        return result
    }
}

class NetworkProductDetailFetcher_ParserTests: XCTestCase {

    var parser: NetworkProductDetailFetcher.Parser!

    override func setUp() {
        super.setUp()
        parser = NetworkProductDetailFetcher.Parser()
    }

    // MARK: - parse

    func test_parse_shouldReturnError_whenFailingToParse() {
        let error = parser.parse(invalidData).error as? DataParserError
        XCTAssertEqual(error, .couldNotParseResponse)
    }

    func test_parse_shouldReturnProductDetail_whenParsingSuccessful() {

    }

    // MARK: - Helpers

    var invalidData: Data {
        return "not valid data".data(using: .utf8)!
    }
}

