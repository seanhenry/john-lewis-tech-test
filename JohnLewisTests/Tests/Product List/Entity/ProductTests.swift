import XCTest
@testable import JohnLewis

class ProductTests: XCTestCase {

    // MARK: - ==

    func test_shouldBeEqual_whenPropertiesAreEqual() {
        XCTAssert(isEqual())
    }

    func test_shouldNotBeEqual_whenPropertiesAreNotEqual() {
        XCTAssertFalse(isEqual(id: "different"))
        XCTAssertFalse(isEqual(title: "different"))
        XCTAssertFalse(isEqual(price: "different"))
        XCTAssertFalse(isEqual(imagePath: "different"))
    }

    // MARK: - Helpers

    func isEqual(
        id: String = "id",
        title: String = "title",
        price: String = "£99.99",
        imagePath: String = "path/to/image"
    ) -> Bool {
        let product = Product(id: "id", title: "title", price: "£99.99", imagePath: "path/to/image")
        let other = Product(id: id, title: title, price: price, imagePath: imagePath)
        return product == other
    }
}
