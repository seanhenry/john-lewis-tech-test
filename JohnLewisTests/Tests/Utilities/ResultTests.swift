import XCTest
@testable import JohnLewis

class ResultTests: XCTestCase {
    
    var result: Result<String, String>!
    
    // MARK: - result
    
    func test_result_shouldBeNil_whenUnderlyingTypeIsFailure() {
        result = .failure("")
        XCTAssertNil(result.result)
    }
    
    func test_result_shouldBeCorrectValue_whenUnderlyingTypeIsSuccess() {
        result = .success("hello")
        XCTAssertEqual(result.result, "hello")
    }
    
    // MARK: - error
    
    func test_error_shouldBeNil_whenUnderlyingTypeIsSuccess() {
        result = .success("")
        XCTAssertNil(result.error)
    }
    
    func test_error_shouldBeCorrectValue_whenUnderlyingTypeIsFailure() {
        result = .failure("hello")
        XCTAssertEqual(result.error, "hello")
    }

    // MARK: - isSuccess

    func test_isSuccess_shouldBeFalse_whenUnderlyingTypeIsFailure() {
        result = .failure("boo")
        XCTAssertFalse(result.isSuccess)
    }

    func test_isSuccess_shouldBeTrue_whenUnderlyingTypeIsSuccess() {
        result = .success("yay")
        XCTAssertTrue(result.isSuccess)
    }
    
    // MARK: - isSuccess(with:)
    
    func test_isSuccessWithResult_shouldBeFalse_whenResultIsNil() {
        result = .failure("")
        XCTAssertFalse(result.isSuccess(with: nil))
    }
    
    func test_isSuccessWithResult_shouldBeFalse_whenNotSuccess() {
        result = .failure("")
        XCTAssertFalse(result.isSuccess(with: ""))
    }
    
    func test_isSuccessWithResult_shouldBeFalse_whenSuccessIsNotEqual() {
        result = .success("123")
        XCTAssertFalse(result.isSuccess(with: "456"))
    }
    
    func test_isSuccessWithResult_shouldBeTrue_whenSuccessIsEqual() {
        result = .success("123")
        XCTAssertTrue(result.isSuccess(with: "123"))
    }
    
    // MARK: - isFailure(with:)
    
    func test_isFailureWithError_shouldBeFalse_whenErrorIsNil() {
        result = .failure("")
        XCTAssertFalse(result.isFailure(with: nil))
    }
    
    func test_isFailureWithError_shouldBeFalse_whenNotFailure() {
        result = .success("")
        XCTAssertFalse(result.isFailure(with: ""))
    }
    
    func test_isFailureWithError_shouldBeFalse_whenFailureIsNotEqual() {
        result = .failure("123")
        XCTAssertFalse(result.isFailure(with: "456"))
    }
    
    func test_isFailureWithError_shouldBeTrue_whenFailureIsEqual() {
        result = .failure("123")
        XCTAssertTrue(result.isFailure(with: "123"))
    }
}
