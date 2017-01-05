import XCTest
@testable import JohnLewis

class NetworkImageFetcherTests: XCTestCase {

    var fetcher: NetworkImageFetcher!
    var mockedRequestFactory: MockRequestFactory!
    var mockedSpecialRequest: SpecialMockRequest!
    var mockedRequest: MockRequest {
        return mockedRequestFactory.stubbedRequest
    }
    let url = URL(string: "http://test.com/some/path")!

    override func setUp() {
        super.setUp()
        mockedSpecialRequest = SpecialMockRequest()
        mockedRequestFactory = MockRequestFactory()
        fetcher = NetworkImageFetcher(requestFactory: mockedRequestFactory)
    }

    // MARK: - fetch

    func test_fetch_shouldCreateRequest_fromURL() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequestFactory.invokedURL, url)
        XCTAssert(mockedRequest.didGet)
    }

    func test_fetch_shouldNotCreateRequest_whenOneIsAlreadyInProgress() {
        mockedRequestFactory.stubbedRequest = mockedSpecialRequest
        fetcher.fetch(from: url) { _ in  }
        fetcher.fetch(from: url) { result in
            let error = result.error as? NetworkImageFetcher.Error
            XCTAssertEqual(error, .requestAlreadyInProgress)
        }
        XCTAssertEqual(mockedSpecialRequest.invocationCount, 1)
    }

    func test_fetch_shouldBeAbleToRepeatARequest_whenTheOriginalHasFinished() {
        fetchSynchronously()
        fetchSynchronously()
        XCTAssertEqual(mockedRequest.invocationCount, 2)
    }

    func test_fetch_shouldPassError_whenRequestFails() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }

    func test_fetch_shouldPassData_whenRequestSucceeds() {
        let data = "image data".data(using: .utf8)!
        mockedRequest.stubbedResult = .success(data)
        XCTAssertEqual(fetchSynchronously().result, data)
    }

    // MARK: - Helpers

    @discardableResult
    func fetchSynchronously() -> ImageFetcherResult {
        var result: ImageFetcherResult!
        fetcher.fetch(from: url) { r in
            result = r
        }
        return result
    }

    class SpecialMockRequest: MockRequest {

        var invokedCompletion: Request.Completion?

        override func get(from path: String, completion: @escaping Request.Completion) {
            invokedCompletion = completion
            super.get(from: path) { _ in  }
        }

    }
}
