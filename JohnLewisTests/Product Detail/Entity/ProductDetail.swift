import XCTest
@testable import JohnLewis

class ProductDetailTests: XCTestCase {

    // MARK: - ==

    func test_shouldBeEqual_whenPropertiesAreEqual() {
        XCTAssert(isEqual())
    }

    func test_shouldNotBeEqual_whenPropertiesAreNotEqual() {
        XCTAssertFalse(isEqual(title: "different"))
        XCTAssertFalse(isEqual(imagePath: "different"))
        XCTAssertFalse(isEqual(description: "different"))
    }

    // MARK: - Helpers

    func isEqual(
        title: String = "title",
        imagePath: String = "/path/to/image",
        description: String = "description"
    ) -> Bool {
        let productDetail = ProductDetail(title: "title", imagePath: "/path/to/image", description: "description")
        let other = ProductDetail(title: title, imagePath: imagePath, description: description)
        return productDetail == other
    }
}
