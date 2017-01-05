import Foundation

import XCTest
@testable import JohnLewis

class ProductListViewPresenterTests: XCTestCase {

    var presenter: ProductListViewPresenter!
    var mockedProductListFetcher: MockProductListFetcher!
    var mockedView: MockProductListView!
    var mockedImageFetcher: MockImageFetcher!

    override func setUp() {
        super.setUp()
        mockedProductListFetcher = MockProductListFetcher()
        mockedImageFetcher = MockImageFetcher()
        mockedView = MockProductListView()
        presenter = ProductListViewPresenter(productListFetcher: mockedProductListFetcher, imageFetcher: mockedImageFetcher, view: mockedView)
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

    // MARK: - Helpers

    var validProducts: [Product] {
        return [
            Product(title: "title1", price: "price1", imagePath: "imagePath1")
        ]
    }

    func stubValidProducts() {
        mockedProductListFetcher.stubbedResult = .success(validProducts)
    }
}

