import Foundation
import XCTest
@testable import JohnLewis

class NetworkProductListFetcherTests: XCTestCase {

    var fetcher: NetworkProductListFetcher!
    var mockedRequest: MockRequest!

    override func setUp() {
        super.setUp()
        mockedRequest = MockRequest()
        fetcher = NetworkProductListFetcher(request: mockedRequest)
    }

    // MARK: - fetch

    func test_fetch_shouldMakeNetworkRequest() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequest.invokedPath, "/products/search?q=dishwasher&pageSize=20")
    }

    func test_fetch_shouldPassError_whenNetworkError() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    // MARK: - Helpers

    @discardableResult
    func fetchSynchronously() -> ProductListFetcherResult {
        var result: ProductListFetcherResult!
        fetcher.fetch { r in
            result = r
        }
        return result
    }
}

class NetworkProductListFetcher_ParserTests: XCTestCase {

    var parser: NetworkProductListFetcher.Parser!

    override func setUp() {
        super.setUp()
        parser = NetworkProductListFetcher.Parser()
    }

    // MARK: - parse

    func test_parse_shouldPassError_whenUnableToParseObject() {
        let error = parser.parse(invalidObjectData).error as? DataParserError
        XCTAssertEqual(error, .couldNotParseResponse)
    }

    func test_parse_shouldParseProducts_whenValidObjectIsReturned() {
        XCTAssertEqual(parser.parse(validObjectData).result!, products)
    }

    func test_parse_shouldReturnEmptyArray_whenNoProductsAreReturned() {
        XCTAssert(parser.parse(validEmptyObjectData).result!.isEmpty)
    }

    func test_parse_shouldIgnoreInvalidObjects() {
        XCTAssertEqual(parser.parse(partiallyValidObjectData).result!, products)
    }

    // MARK: - Helpers

    var invalidObjectData: Data {
        return "not a valid response".data(using: .utf8)!
    }

    var validEmptyObjectData: Data {
        let dictionary = [
            "products": []
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }

    var validObjectData: Data {
        let dictionary = [
            "products": [
                [
                    "title": "Fully Integrated Dishwasher",
                    "price": [
                        "now": "449.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"
                ],
                [
                    "title": "Freestanding Dishwasher",
                    "price": [
                        "now": "379.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?"
                ]
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }

    var partiallyValidObjectData: Data {
        let dictionary = [
            "products": [
                // valid
                [
                    "title": "Fully Integrated Dishwasher",
                    "price": [
                        "now": "449.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"
                ],
                // missing title
                [
                    "price": [
                        "now": "1"
                    ],
                    "image": "http://image"
                ],
                // missing price
                [
                    "title": "Title",
                    "image": "http://image"
                ],
                // missing image
                [
                    "title": "Title",
                    "price": [
                        "now": "1"
                    ]
                ],
                // valid
                [
                    "title": "Freestanding Dishwasher",
                    "price": [
                        "now": "379.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?"
                ]
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }

    var products: [Product] {
        return [
            Product(title: "Fully Integrated Dishwasher", price: "£449.00", imagePath: "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"),
            Product(title: "Freestanding Dishwasher", price: "£379.00", imagePath: "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?")
        ]
    }
}

