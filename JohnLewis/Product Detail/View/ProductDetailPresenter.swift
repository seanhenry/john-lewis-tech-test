import Foundation
import UIKit

class ProductDetailPresenter: ProductDetailEventHandler {

    private let productID: String
    private let productDetailFetcher: ProductDetailFetcher
    private let imageFetcher: ImageFetcher
    private weak var view: ProductDetailView?

    init(productID: String, productDetailFetcher: ProductDetailFetcher, imageFetcher: ImageFetcher, view: ProductDetailView) {
        self.productID = productID
        self.productDetailFetcher = productDetailFetcher
        self.imageFetcher = imageFetcher
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
            fetchImage(from: detail.imagePath)
        }
    }

    private func fetchImage(from path: String) {
        guard let url = URL(string: path) else { return }
        imageFetcher.fetch(from: url) { [weak self] result in
            self?.handleFetchedImage(result)
        }
    }

    private func handleFetchedImage(_ result: ImageFetcherResult) {
        if let data = result.result,
           let image = UIImage(data: data) {
            view?.showImage(image)
        }
    }
}
