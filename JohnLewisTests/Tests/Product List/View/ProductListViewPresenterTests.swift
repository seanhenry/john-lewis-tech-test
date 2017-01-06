import Foundation

import XCTest
@testable import JohnLewis

class ProductListViewPresenterTests: XCTestCase {

    var presenter: ProductListViewPresenter!
    var mockedProductListFetcher: MockProductListFetcher!
    var mockedView: MockProductListView!
    var mockedImageFetcher: MockImageFetcher!
    var mockedRouter: MockProductDetailRouter!

    override func setUp() {
        super.setUp()
        mockedProductListFetcher = MockProductListFetcher()
        mockedImageFetcher = MockImageFetcher()
        mockedView = MockProductListView()
        mockedRouter = MockProductDetailRouter()
        presenter = ProductListViewPresenter(productListFetcher: mockedProductListFetcher, imageFetcher: mockedImageFetcher, view: mockedView, router: mockedRouter)
    }

    // MARK: - fetchProducts

    func test_fetchProducts_shouldFetchProducts() {
        presenter.fetchProducts()
        XCTAssert(mockedProductListFetcher.didFetch)
    }

    func test_fetchProducts_shouldShowError_whenFetchingFails() {
        mockedProductListFetcher.stubbedResult = .failure(testError)
        presenter.fetchProducts()
        XCTAssertEqual(mockedView.invokedErrorMessage, "There was a problem fetching the products. Please try again later.")
    }

    func test_fetchProducts_shouldShowProducts_whenFetchingSucceeds() {
        stubValidProducts()
        presenter.fetchProducts()
        XCTAssertEqual(mockedView.invokedProducts!, validProducts)
    }

    // MARK: - fetchImage(at:)

    func test_fetchImage_shouldNotFetchImage_whenOutOfBounds() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.fetchImage(at: 1)
        XCTAssertFalse(mockedImageFetcher.didFetch)
        presenter.fetchImage(at: -1)
        XCTAssertFalse(mockedImageFetcher.didFetch)
    }

    func test_fetchImage_shouldFetchImage() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.fetchImage(at: 0)
        XCTAssert(mockedImageFetcher.didFetch)
        XCTAssertEqual(mockedImageFetcher.invokedURL?.absoluteString, validProducts[0].imagePath)
    }

    func test_fetchImage_shouldShowImageInView_whenImageIsFetched() {
        stubValidProducts()
        presenter.fetchProducts()
        mockedImageFetcher.stubbedResult = .success(testImageData)
        presenter.fetchImage(at: 0)
        XCTAssertNotNil(mockedView.invokedImage)
        XCTAssertEqual(mockedView.invokedImageIndex, 0)
    }

    // MARK: - showDetails

    func test_showDetails_shouldCallRouter() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.showDetails(at: 0)
        XCTAssertEqual(mockedRouter.invokedID, validProducts[0].id)
    }

    func test_showDetails_shouldNotCallRouter_whenIndexIsOutOfBounds() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.showDetails(at: 1)
        XCTAssertFalse(mockedRouter.didShowProductDetails)
        presenter.showDetails(at: -1)
        XCTAssertFalse(mockedRouter.didShowProductDetails)
    }

    // MARK: - Helpers

    var validProducts: [Product] {
        return [
            Product(id: "id1", title: "title1", price: "price1", imagePath: "imagePath1")
        ]
    }

    func stubValidProducts() {
        mockedProductListFetcher.stubbedResult = .success(validProducts)
    }
}

