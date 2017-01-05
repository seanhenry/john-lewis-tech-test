import XCTest
@testable import JohnLewis

class NetworkImageFetcherTests: XCTestCase {

    var fetcher: NetworkImageFetcher!
    var mockedRequestFactory: MockRequestFactory!
    let url = URL(string: "http://test.com/some/path")!

    override func setUp() {
        super.setUp()
        mockedRequestFactory = MockRequestFactory()
        fetcher = NetworkImageFetcher(requestFactory: mockedRequestFactory)
    }

    // MARK: - fetch

    func test_fetch_shouldCreateRequest_fromURL() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequestFactory.invokedURL, url)
        XCTAssert(mockedRequestFactory.stubbedRequest.didGet)
    }

    func test_fetch_shouldPassError_whenRequestFails() {
        mockedRequestFactory.stubbedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    func test_fetch_shouldPassData_whenRequestSucceeds() {
        let data = "image data".data(using: .utf8)!
        mockedRequestFactory.stubbedRequest.stubbedResult = .success(data)
        XCTAssertEqual(fetchSynchronously().result, data)
    }

    // MARK: - Helpers

    func fetchSynchronously() -> NetworkImageFetcher.ImageFetcherResult {
        var result: NetworkImageFetcher.ImageFetcherResult!
        fetcher.fetch(from: url) { r in
            result = r
        }
        return result
    }
}
