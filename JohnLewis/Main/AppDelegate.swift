import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let productListViewController = navigationController.viewControllers[0] as! ProductListCollectionViewController
        let request = JLRequest(baseURL: johnLewisBaseURL)
        let presenter = ProductListViewPresenter(
            productListFetcher: NetworkProductListFetcher(request: request),
            imageFetcher: NetworkImageFetcher(),
            view: productListViewController,
            router: PushingProductDetailRouter(navigationController: navigationController)
        )
        productListViewController.eventHandler = presenter
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
