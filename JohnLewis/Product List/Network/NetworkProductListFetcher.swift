import Foundation
import SwiftyJSON

class NetworkProductListFetcher: ProductListFetcher {

    enum Error: Swift.Error {
        case couldNotParseResponse
    }

    private let request: Request

    init(request: Request) {
        self.request = request
    }

        request.get(from: "/products/search?pageSize=20") { [weak self] result in
    func fetch(completion: @escaping (ProductListFetcherResult) -> ()) {
            self?.handleResponse(result: result, completion: completion)
        }
    }

    private func handleResponse(result: Request.RequestResult, completion: (ProductListFetcherResult) -> ()) {
        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response):
            completion(parse(response))
        }
    }

    private func parse(_ response: Data) -> ProductListFetcherResult {
        guard let products = JSON(data: response)["products"].array else {
            return .failure(Error.couldNotParseResponse)
        }
        return .success(products.flatMap(toProduct))
    }

    private func toProduct(json: JSON) -> Product? {
        guard let title = json["title"].string,
              let price = json["price"]["now"].string,
              let imagePath = json["image"].string else {
            return nil
        }
        return Product(title: title, price: "£" + price, imagePath: imagePath)
    }
}
