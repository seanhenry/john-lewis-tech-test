import XCTest
@testable import JohnLewis

class ProductDetailTests: XCTestCase {

    // MARK: - ==

    func test_shouldBeEqual_whenPropertiesAreEqual() {
        XCTAssert(isEqual())
    }

    func test_shouldNotBeEqual_whenPropertiesAreNotEqual() {
        XCTAssertFalse(isEqual(title: "different"))
        XCTAssertFalse(isEqual(price: "different"))
        XCTAssertFalse(isEqual(imagePath: "different"))
        XCTAssertFalse(isEqual(description: "different"))
        XCTAssertFalse(isEqual(guarantee: "different"))
    }

    // MARK: - Helpers

    func isEqual(
        title: String = "title",
        price: String = "99.99",
        imagePath: String = "/path/to/image",
        description: String = "description",
        guarantee: String = "2 year warranty"
    ) -> Bool {
        let productDetail = ProductDetail(title: "title", price: "99.99", imagePath: "/path/to/image", description: "description", guarantee: "2 year warranty")
        let other = ProductDetail(title: title, price: price, imagePath: imagePath, description: description, guarantee: guarantee)
        return productDetail == other
    }
}
