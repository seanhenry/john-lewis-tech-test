import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let productListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ProductListCollectionViewController
        let request = JLRequest(baseURL: URL(string: "https://api.johnlewis.com/v1")!)
        let presenter = ProductListViewPresenter(productListFetcher: NetworkProductListFetcher(request: request), imageFetcher: NetworkImageFetcher(), view: productListViewController)
        productListViewController.eventHandler = presenter
        window.rootViewController = productListViewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
