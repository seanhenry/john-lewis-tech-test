import Foundation

class ProductListViewPresenter: ProductListEventHandler {

    private let productListFetcher: ProductListFetcher
    private weak var view: ProductListView?

    init(productListFetcher: ProductListFetcher, view: ProductListView) {
        self.productListFetcher = productListFetcher
        self.view = view
    }

    func fetchProducts() {
        productListFetcher.fetch { [weak self] result in
            self?.handleFetchedProducts(result)
        }
    }

    private func handleFetchedProducts(_ result: ProductListFetcherResult) {
        switch result {
        case .failure:
            view?.showErrorMessage("There was a problem fetching the products. Please try again later.")
        case .success(let products):
            view?.showProducts(products)
        }
    }
}
