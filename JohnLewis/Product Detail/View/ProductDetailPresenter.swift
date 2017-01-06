
class ProductDetailPresenter {

    private let productID: String
    private let productDetailFetcher: ProductDetailFetcher
    private weak var view: ProductDetailView?

    init(productID: String, productDetailFetcher: ProductDetailFetcher, view: ProductDetailView) {
        self.productID = productID
        self.productDetailFetcher = productDetailFetcher
        self.view = view
    }

    func fetchDetails() {
        productDetailFetcher.fetch(id: productID) { [weak self] result in
            self?.handleFetchedDetails(result)
        }
    }

    private func handleFetchedDetails(_ result: Result<ProductDetail, Error>) {
        switch result {
        case .failure:
            view?.showErrorMessage("There was a problem fetching the product details. Please try again later.")
        case .success(let detail):
            view?.showProductDetail(detail)
        }
    }
}
