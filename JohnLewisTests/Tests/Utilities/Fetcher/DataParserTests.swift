
import Foundation
import XCTest
@testable import JohnLewis

class DataParserTests: XCTestCase {

    var parser: DataParser<String>!

    override func setUp() {
        super.setUp()
        parser = DataParser()
    }

    // MARK: - parse

    func test_parse_shouldReturnErrorByDefault() {
        let error = parser.parse(Data()).error as? DataParserError
        XCTAssertEqual(error, .couldNotParseResponse)
    }
}

