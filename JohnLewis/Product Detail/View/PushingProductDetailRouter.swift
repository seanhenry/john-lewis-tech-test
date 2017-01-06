import UIKit

class PushingProductDetailRouter: ProductDetailRouter {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showProductDetails(id: String) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailCollectionViewController") as! ProductDetailCollectionViewController
        let detailFetcher = NetworkProductDetailFetcher(request: JLRequest(baseURL: johnLewisBaseURL))
        let presenter = ProductDetailPresenter(productID: id, productDetailFetcher: detailFetcher, imageFetcher: NetworkImageFetcher(), view: viewController)
        viewController.eventHandler = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
}
