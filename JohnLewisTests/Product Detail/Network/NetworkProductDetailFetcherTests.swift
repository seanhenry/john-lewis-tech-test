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
        XCTAssertEqual(parser.parse(validData).result, productDetail)
    }

    func test_parse_shouldReturnError_whenSomeDetailsAreMissing() {
        assertThatPartialDataReturnsError(createPartialData(title: nil))
        assertThatPartialDataReturnsError(createPartialData(url: nil))
        assertThatPartialDataReturnsError(createPartialData(description: nil))
    }

    // MARK: - Helpers

    var invalidData: Data {
        return "not valid data".data(using: .utf8)!
    }

    var validData: Data {
        return createPartialData()
    }

    var productDetail: ProductDetail {
        return ProductDetail(title: "Integrated Dishwasher", imagePath: "http://path/to/image", description: "description")
    }

    func createPartialData(
        title: NSString? = "Integrated Dishwasher" as NSString,
        url: NSString? = "http://path/to/image" as NSString,
        description: NSString? = "description" as NSString
    ) -> Data {
        let dictionary: [String: Any] = [
            "title": title ?? NSNull(),
            "media": [
                "images": [
                    "urls": [
                        url ?? NSNull()
                    ]
                ]
            ],
            "details": [
                "productInformation": description ?? NSNull()
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }

    func assertThatPartialDataReturnsError(_ data: Data, file: StaticString = #file, line: UInt = #line) {
        let error = parser.parse(data).error as? DataParserError
        XCTAssertEqual(error, .couldNotParseResponse, file: file, line: line)
    }
}

