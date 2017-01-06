import XCTest
@testable import JohnLewis

class ProductDetailPresenterTests: XCTestCase {

    var presenter: ProductDetailPresenter!
    var mockedDetailFetcher: MockProductDetailFetcher!
    var mockedView: MockProductDetailView!
    let id = "product_id"

    override func setUp() {
        super.setUp()
        mockedDetailFetcher = MockProductDetailFetcher()
        mockedView = MockProductDetailView()
        presenter = ProductDetailPresenter(productID: id, productDetailFetcher: mockedDetailFetcher, view: mockedView)
    }

    // MARK: - fetchDetails

    func test_fetchDetails_shouldFetchProduct_withID() {
        presenter.fetchDetails()
        XCTAssertEqual(mockedDetailFetcher.invokedID, id)
    }

    func test_fetchDetails_shouldNotifyView_whenFetchFails() {
        mockedDetailFetcher.stubbedResult = .failure(testError)
        presenter.fetchDetails()
        XCTAssertEqual(mockedView.invokedErrorMessage, "There was a problem fetching the product details. Please try again later.")
    }

    func test_fetchDetails_shouldNotifyView_whenFetchingSucceeds() {
        let productDetail = ProductDetail(title: "title", imagePath: "image", description: "description")
        mockedDetailFetcher.stubbedResult = .success(productDetail)
        presenter.fetchDetails()
        XCTAssertEqual(mockedView.invokedProductDetail, productDetail)
    }
}
