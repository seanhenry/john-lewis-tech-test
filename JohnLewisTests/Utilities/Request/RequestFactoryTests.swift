import Foundation
import XCTest
@testable import JohnLewis

class RequestFactoryTests: XCTestCase {

    var factory: DefaultRequestFactory!

    override func setUp() {
        super.setUp()
        factory = DefaultRequestFactory()
    }

    // MARK: - create

    func test_create() {
        let request = factory.create(fromURL: URL(string: "http://hello.com/some/path")!)
        XCTAssert(request is JLRequest)
    }
}
