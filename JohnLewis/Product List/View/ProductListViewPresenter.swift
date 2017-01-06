import Foundation
import UIKit

class ProductListViewPresenter: ProductListEventHandler {

    private let productListFetcher: ProductListFetcher
    private let imageFetcher: ImageFetcher
    private weak var view: ProductListView?
    private var products: [Product]?
    private let router: ProductDetailRouter

    init(productListFetcher: ProductListFetcher, imageFetcher: ImageFetcher, view: ProductListView, router: ProductDetailRouter) {
        self.productListFetcher = productListFetcher
        self.imageFetcher = imageFetcher
        self.view = view
        self.router = router
    }

    func fetchProducts() {
        productListFetcher.fetch { [weak self] result in
            self?.handleFetchedProducts(result)
        }
    }

    func fetchImage(at index: Int) {
        guard let products = products,
              let imageURL = imageURL(at: index, in: products) else { return }
        imageFetcher.fetch(from: imageURL) { [weak self] result in
            self?.handleFetchedImage(result, at: index)
        }
    }

    func showDetails(at index: Int) {
        guard let products = products, isIndexValid(index, in: products) else { return }
        router.showProductDetails(id: products[index].id)
    }

    private func handleFetchedProducts(_ result: ProductListFetcherResult) {
        switch result {
        case .failure:
            view?.showErrorMessage("There was a problem fetching the products. Please try again later.")
        case .success(let products):
            self.products = products
            view?.showProducts(products)
        }
    }

    private func handleFetchedImage(_ result: ImageFetcherResult, at index: Int) {
        if let imageData = result.result,
           let image = UIImage(data: imageData) {
            view?.showImage(image: image, at: index)
        }
    }

    private func imageURL(at index: Int, in products: [Product]) -> URL? {
        guard isIndexValid(index, in: products) else { return nil }
        return URL(string: products[index].imagePath)
    }

    private func isIndexValid(_ index: Int, in products: [Product]) -> Bool {
        return 0 <= index && index < products.count
    }
}
