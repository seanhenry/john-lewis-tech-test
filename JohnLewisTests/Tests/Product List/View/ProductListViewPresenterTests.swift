import Foundation

import XCTest
@testable import JohnLewis

class ProductListViewPresenterTests: XCTestCase {

    var presenter: ProductListViewPresenter!
    var mockedProductListFetcher: MockProductListFetcher!
    var mockedView: MockProductListView!

    override func setUp() {
        super.setUp()
        mockedProductListFetcher = MockProductListFetcher()
        mockedView = MockProductListView()
        presenter = ProductListViewPresenter(productListFetcher: mockedProductListFetcher, view: mockedView)
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
        mockedProductListFetcher.stubbedResult = .success(validProducts)
        presenter.fetchProducts()
        XCTAssertEqual(mockedView.invokedProducts!, validProducts)
    }

    // MARK: - Helpers

    var validProducts: [Product] {
        return [
            Product(title: "title1", price: "price1", imagePath: "imagePath1")
        ]
    }
}

