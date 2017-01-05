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
        XCTAssertEqual(mockedRequest.invokedPath, "/products/search?pageSize=20")
    }

    func test_fetch_shouldPassError_whenNetworkError() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    func test_fetch_shouldPassError_whenUnableToParseObject() {
        mockedRequest.stubbedResult = .success(invalidObjectData)
        let error = fetchSynchronously().error as? NetworkProductListFetcher.Error
        XCTAssertEqual(error, .couldNotParseResponse)
    }

    func test_fetch_shouldParseProducts_whenValidObjectIsReturned() {
        mockedRequest.stubbedResult = .success(validObjectData)
        XCTAssertEqual(fetchSynchronously().result!, products)
    }

    func test_fetch_shouldReturnEmptyArray_whenNoProductsAreReturned() {
        mockedRequest.stubbedResult = .success(validEmptyObjectData)
        XCTAssert(fetchSynchronously().result!.isEmpty)
    }

    func test_fetch_shouldIgnoreInvalidObjects() {
        mockedRequest.stubbedResult = .success(partiallyValidObjectData)
        XCTAssertEqual(fetchSynchronously().result!, products)
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

    @discardableResult
    func fetchSynchronously() -> ProductListFetcherResult {
        var result: ProductListFetcherResult!
        fetcher.fetch { r in
            result = r
        }
        return result
    }
}
