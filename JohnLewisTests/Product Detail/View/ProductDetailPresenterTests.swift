import XCTest
@testable import JohnLewis

class ProductDetailPresenterTests: XCTestCase {

    var presenter: ProductDetailPresenter!
    var mockedDetailFetcher: MockProductDetailFetcher!
    var mockedImageFetcher: MockImageFetcher!
    var mockedView: MockProductDetailView!
    let id = "product_id"
    let productDetail = ProductDetail(title: "title", price: "£99.99", imagePath: "image", description: "description", guarantee: "guarantee")

    override func setUp() {
        super.setUp()
        mockedDetailFetcher = MockProductDetailFetcher()
        mockedImageFetcher = MockImageFetcher()
        mockedView = MockProductDetailView()
        presenter = ProductDetailPresenter(productID: id, productDetailFetcher: mockedDetailFetcher, imageFetcher: mockedImageFetcher, view: mockedView)
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
        stubProductDetail()
        presenter.fetchDetails()
        XCTAssertEqual(mockedView.invokedProductDetail, productDetail)
    }

    func test_fetchDetails_shouldFetchImage_whenFetchingDetails() {
        stubProductDetail()
        presenter.fetchDetails()
        XCTAssertEqual(mockedImageFetcher.invokedURL, URL(string: productDetail.imagePath)!)
    }

    func test_fetchDetails_shouldShowImage_whenImageIsFetched() {
        stubProductDetail()
        presenter.fetchDetails()
        mockedImageFetcher.stubbedResult = .success(testImageData)
        presenter.fetchDetails()
        XCTAssertNotNil(mockedView.invokedImage)
    }

    // MARK: - Helpers

    func stubProductDetail() {
        mockedDetailFetcher.stubbedResult = .success(productDetail)
    }
}
